// db/pool.js
const mysql = require("mysql2/promise");

function must(v, name) {
  if (!v) throw new Error(`Missing env: ${name}`);
  return v;
}

let pool;

if (process.env.MYSQL_URL) {
  // ✅ Railway가 mysql://user:pass@host:port/db 형태로 주는 경우
  pool = mysql.createPool(process.env.MYSQL_URL);
} else {
  // ✅ Render/Railway 환경변수 5종으로 주는 경우
  pool = mysql.createPool({
    host: must(process.env.MYSQL_HOST, "MYSQL_HOST"),
    port: Number(process.env.MYSQL_PORT || 3306),
    user: must(process.env.MYSQL_USER, "MYSQL_USER"),
    password: must(process.env.MYSQL_PASSWORD, "MYSQL_PASSWORD"),
    database: must(process.env.MYSQL_DATABASE, "MYSQL_DATABASE"),
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0,
    // 필요하면 아래 추가(일부 환경에서 필수)
    // ssl: { rejectUnauthorized: false },
  });
}

module.exports = pool;
