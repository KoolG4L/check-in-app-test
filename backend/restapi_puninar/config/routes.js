import express from "express";
import { checkCheckIn, checkCheckOut, createCheckIn, createCheckOut, findCheckHistory, updateCheckIn, updateCheckOut, validateCheckIn } from "./controller.js";

const router = express();

router.get("/validateCheckIn", validateCheckIn)

//CHECK DATE

//CHECK IN
router.get("/checkIn/check", checkCheckIn)
router.post("/checkIn/create", createCheckIn)
router.put("/checkIn/update/:id", updateCheckIn)

//CHECK OUT
router.get("/checkOut/check", checkCheckOut)
router.post("/checkOut/create", createCheckOut)
router.put("/checkOut/update/:id", updateCheckOut)

router.post("/history", findCheckHistory)




export default router;

