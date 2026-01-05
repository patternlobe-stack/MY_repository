const express = require("express");
const router = express.Router();
const controller = require("../controllers/schedule.controller");

router.get("/month", controller.getMonthlySchedule);

module.exports = router;
