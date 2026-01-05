const express = require("express");
const router = express.Router();
const controller = require("../controllers/schedule.controller");

router.get("/month", controller.getMonthlySchedule);

router.get("/test", (req, res) => {
  res.send("SCHEDULE ROUTE OK");
});

module.exports = router;
