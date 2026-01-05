// controllers/schedule.controller.js
const pool = require("../db/pool");

// 5일 순환 고정
const CYCLE = ["D", "E", "N", "B", "OFF"];
const SHIFT_TO_INDEX = { D: 0, E: 1, N: 2, B: 3, OFF: 4 };

function ymd(dateObj) {
  const y = dateObj.getFullYear();
  const m = String(dateObj.getMonth() + 1).padStart(2, "0");
  const d = String(dateObj.getDate()).padStart(2, "0");
  return `${y}-${m}-${d}`;
}

function diffDays(fromYmd, toYmd) {
  const a = new Date(fromYmd + "T00:00:00");
  const b = new Date(toYmd + "T00:00:00");
  const ms = b - a;
  return Math.floor(ms / (1000 * 60 * 60 * 24));
}

function isWeekend(dateObj) {
  const day = dateObj.getDay(); // 0 Sun, 6 Sat
  return day === 0 || day === 6;
}

/**
 * ✅ 개인별 선호/예외 규칙은 "최종 확정 직전"에만 적용
 * - 박은희: E → D
 * - 김미숙/이지연: D → E
 * - OFF/null 은 건드리지 않음 (공휴일/주말OFF 유지)
 */
function applyPersonalRules(name, shift) {
  if (!shift) return shift; // null 그대로
  if (shift === "OFF") return shift; // OFF는 어떤 경우에도 유지

  // 🔴 박은희: E 근무는 무조건 D로 치환
  if (name === "박은희" && shift === "E") return "D";

  // 🔴 김미숙, 이지연: D 근무는 무조건 E로 치환
  if ((name === "김미숙" || name === "이지연") && shift === "D") return "E";

  return shift;
}

/**
 * ✅ E->D로 바꾸면 안 되는 사람(선호/예외)
 * - 김미숙/이지연은 E 선호라서 "E를 D로 내리기" 후보에서 제외
 */
function isProtectedFromEtoD(name) {
  return name === "김미숙" || name === "이지연";
}

/**
 * ✅ 하루치 보정(운영 규칙)
 * - 목표: "매일 D가 최소 1명" & "E가 2명 이상이면 1명은 D로"
 * - 단, 김미숙/이지연(E선호)은 E->D 보정 대상에서 제외
 *
 * 주의:
 * - 여기서는 "하루 운영"만 보정하고, 5일 패턴(월간 골고루) 자체는 건드리지 않음
 * - OFF/null은 제외
 */
function rebalanceDay(rows) {
  // rows: [{user_id,name,shift_type}, ...]
  const working = rows.filter((r) => r.shift_type && r.shift_type !== "OFF");

  const dCount = working.filter((r) => r.shift_type === "D").length;
  const eWorkers = working.filter((r) => r.shift_type === "E");

  // ✅ 조건: D가 0이거나, E가 2명 이상이면 보정
  if (dCount === 0 || eWorkers.length >= 2) {
    // 후보: E이면서 보호대상이 아닌 사람
    // 필요하면 여기서 우선순위도 박을 수 있음(예: 김현주 먼저)
    const candidate = eWorkers.find((r) => !isProtectedFromEtoD(r.name));

    if (candidate) {
      candidate.shift_type = "D";
    }
  }

  return rows;
}

exports.getMonthlySchedule = async (req, res) => {
  try {
    const year = Number(req.query.year);
    const month = Number(req.query.month); // 1~12
    if (!year || !month || month < 1 || month > 12) {
      return res.json({
        ok: false,
        message: "year/month required (month: 1~12)",
      });
    }

    const start = new Date(year, month - 1, 1);
    const end = new Date(year, month, 0); // last day
    const startYmd = ymd(start);
    const endYmd = ymd(end);

    // 1) 직원 가져오기
    const [users] = await pool.query(
      `SELECT user_id, name, role, fixed_shift, weekend_off, anchor_date, anchor_shift
       FROM users
       WHERE is_active = 1
       ORDER BY user_id`
    );

    // 2) 공휴일 가져오기
    const [holidaysRows] = await pool.query(
      `SELECT holiday_date FROM holidays
       WHERE holiday_date BETWEEN ? AND ?`,
      [startYmd, endYmd]
    );
    const holidaySet = new Set(
      holidaysRows.map((r) => ymd(new Date(r.holiday_date)))
    );

    // 3) 월 전체 날짜 배열
    const days = [];
    for (let d = new Date(start); d <= end; d.setDate(d.getDate() + 1)) {
      days.push(ymd(new Date(d)));
    }

    // 4) 결과 생성
    const dataByDate = {};
    for (const dateStr of days) dataByDate[dateStr] = [];

    for (const u of users) {
      // (A) 고정근무자
      if (u.fixed_shift) {
        for (const dateStr of days) {
          const dObj = new Date(dateStr + "T00:00:00");
          const isHol = holidaySet.has(dateStr);
          const off = u.weekend_off === 1 && (isWeekend(dObj) || isHol);

          const rawShift = off ? "OFF" : u.fixed_shift;
          const finalShift = applyPersonalRules(u.name, rawShift);

          dataByDate[dateStr].push({
            user_id: u.user_id,
            name: u.name,
            shift_type: finalShift,
          });
        }
        continue;
      }

      // (B) 순환근무자: anchor_date + anchor_shift 기반
      if (!u.anchor_date || !u.anchor_shift) {
        for (const dateStr of days) {
          dataByDate[dateStr].push({
            user_id: u.user_id,
            name: u.name,
            shift_type: null,
          });
        }
        continue;
      }

      const anchorDate = ymd(new Date(u.anchor_date));
      const anchorShift = u.anchor_shift;
      const anchorIdx = SHIFT_TO_INDEX[anchorShift];

      if (anchorIdx === undefined) {
        for (const dateStr of days) {
          dataByDate[dateStr].push({
            user_id: u.user_id,
            name: u.name,
            shift_type: null,
          });
        }
        continue;
      }

      for (const dateStr of days) {
        const d = diffDays(anchorDate, dateStr); // anchor -> target
        let idx = anchorIdx + (d % 5);
        idx = ((idx % 5) + 5) % 5;

        const rawShift = CYCLE[idx];
        const finalShift = applyPersonalRules(u.name, rawShift);

        dataByDate[dateStr].push({
          user_id: u.user_id,
          name: u.name,
          shift_type: finalShift, // ✅ 개인 규칙 적용까지 완료
        });
      }
    }

    // ✅ 5) 날짜별 운영 규칙 보정 적용 (반드시 res.json 전에!)
    for (const dateStr of days) {
      dataByDate[dateStr] = rebalanceDay(dataByDate[dateStr]);
    }

    res.json({
      ok: true,
      year,
      month,
      range: { start: startYmd, end: endYmd },
      holidays_count: holidaySet.size,
      dataByDate,
    });
  } catch (e) {
    res.status(500).json({ ok: false, message: e.message });
  }
};
