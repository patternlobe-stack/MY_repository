const express = require("express");
const cors = require("cors");
const mysql = require("mysql2/promise");

const app = express();
app.use(cors());
app.use(express.json());

// =========================
// Health Check
// =========================
app.get("/health", (req, res) => {
  res.send("OK");
});

// =========================
// MySQL Connection Pool
// =========================
const pool = mysql.createPool({
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT),
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 5,
});

// =========================
// DB Ping Test
// =========================
// dbping (디버그용)
app.get("/dbping", async (req, res) => {
  try {
    const pool = require("./db/pool"); // index.js 기준 경로
    const [rows] = await pool.query("SELECT 1 AS ok");
    return res.json({ ok: true, rows });
  } catch (err) {
    return res.status(500).json({
      ok: false,
      code: err.code || null,
      errno: err.errno || null,
      message: err.message || "Error",
    });
  }
});

// =========================
// Routes (IMPORTANT: before listen)
// =========================
const scheduleRoutes = require("./routes/schedule.routes");
app.use("/api/schedule", scheduleRoutes);

// =========================
// Server Start
// =========================
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log("Server running on", PORT);
});
