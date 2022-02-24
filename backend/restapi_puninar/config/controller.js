import {
  checkCheckInService,
  checkCheckOutExistService,
  createCheckInService,
  createCheckOutService,
  findCheckHistoryService,
  updateCheckInService,
  updateCheckOutService,
  validateCheckInService
} from "./service.js";


export function validateCheckIn(req, res) {
  const data = req.body;
  validateCheckInService(data, (err, results) => {
    if (err) {
      console.log(err);
      return;
    }

    if (results.rowCount == 0) {
      return res.json({
        message: "Belum Check In",
        valid: false,
      });
    }

    return res.json({
      message: "Sudah Check In",
      valid: true,
      data: results.rows
    });
  });
}

//CHECK IN
export function checkCheckIn(req, res) {
  const data = req.body;
  checkCheckInService(data, (err, results) => {
    if (err) {
      console.log(err);
      return;
    }

    if (results.rowCount == 0) {
      return res.json({
        message: "Check in tidak ditemukan",
        valid: false,
        data: results.rows
      });
    }

    return res.json({
      message: "Check in ditemukan",
      valid: true,
      data: results.rows
    });
  });
}

export function createCheckIn(req, res) {
  const data = req.body;

  createCheckInService(data, (err, results) => {
    if (err) {
      console.log(err);
      return;
    }

    if (results.rowCount == 0) {
      return res.status(400).json({
        message: "Check-in gagal",
        valid: false,
        data: []
      });
    }

    return res.status(201).json({
      message: "Check-in berhasil",
      valid: true,
      data: []
    });
  });
}

export function updateCheckIn(req, res) {
  const data = req.body;
  const id = req.params.id

  updateCheckInService(data, id, (err, results) => {
    if (err) {
      console.log(err);
      return;
    }

    if (results.rowCount == 0) {
      return res.status(400).json({
        message: "Check-in gagal",
        valid: false,
        data: []
      });
    }

    return res.json({
      message: "Check-in berhasil",
      valid: true,
      data: []
    });
  });
}

//CHECK OUT
export function checkCheckOut(req, res) {
  const data = req.body;
  checkCheckOutExistService(data, (err, results) => {
    if (err) {
      console.log(err);
      return;
    }

    if (results.rowCount == 0) {
      return res.json({
        message: "Check in tidak ditemukan",
        valid: false,
        data: results.rows
      });
    }

    return res.json({
      message: "Check in ditemukan",
      valid: true,
      data: results.rows
    });
  });
}

export function createCheckOut(req, res) {
  const data = req.body;

  createCheckOutService(data, (err, results) => {
    if (err) {
      console.log(err);
      return;
    }

    if (results.rowCount == 0) {
      return res.status(400).json({
        message: "Check-in gagal",
        valid: false,
        data: []
      });
    }

    return res.status(201).json({
      message: "Check-in berhasil",
      valid: true,
      data: []
    });
  });
}

export function updateCheckOut(req, res) {
  const data = req.body;
  const id = req.params.id

  updateCheckOutService(data, id, (err, results) => {
    if (err) {
      console.log(err);
      return;
    }

    if (results.rowCount == 0) {
      return res.status(400).json({
        message: "Check-in gagal",
        valid: false,
        data: []
      });
    }

    return res.json({
      message: "Check-in berhasil",
      valid: true,
      data: []
    });
  });
}

export function findCheckHistory(req, res) {
  const data = req.body;
  findCheckHistoryService(data, (err, results) => {
    if (err) {
      console.log(err);
      return;
    }

    

    return res.json(results.rows);
  });
}

