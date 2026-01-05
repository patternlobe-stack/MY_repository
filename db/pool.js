const mysql = require("mysql2/promise");

function must(v, name) {
  if (!v) throw new Error(`Missing env: ${name}`);
  return v;
}

const url =
  process.env.MYSQL_URL || process.env.DATABASE_URL || process.env.JAWSDB_URL; // 혹시 몰라서

let pool;

if (url) {
  pool = mysql.createPool(url);
} else {
  pool = mysql.createPool({
    host: must(process.env.MYSQL_HOST, "MYSQL_HOST"),
    port: Number(process.env.MYSQL_PORT || 3306),
    user: must(process.env.MYSQL_USER, "MYSQL_USER"),
    password: must(process.env.MYSQL_PASSWORD, "MYSQL_PASSWORD"),
    database: must(process.env.MYSQL_DATABASE, "MYSQL_DATABASE"),
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0,
    // ssl: { rejectUnauthorized: false }, // 필요할 때만
  });
}

module.exports = pool;
