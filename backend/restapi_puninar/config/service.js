import pool from "./database.js";

export function validateCheckInService(data, callBack) {
  pool.query(
    `(SELECT datetime FROM check_in_records WHERE datetime::date = now()::date)
    UNION ALL
    (SELECT datetime FROM check_out_records WHERE datetime::date = now()::date)
    `,
    (err, results) => {
      if (err) {
        return callBack(err, null);
      }
      return callBack(null, results);
    }
  )
}

export function checkCheckInService(data, callBack) {
  pool.query(
    `SELECT * FROM check_in_records WHERE datetime::date = now()::date LIMIT 1`,
    (err, results) => {
      if (err) {
        return callBack(err, null);
      }
      return callBack(null, results);
    }
  )
}

export function createCheckInService(data, callBack) {
  pool.query(
    `INSERT INTO check_in_records (latitude, longitude, datetime, imageurl) VALUES ($1, $2, $3, $4)`,
    [
      data.latitude,
      data.longitude,
      data.datetime,
      data.imageUrl
    ],
    (err, results) => {
      if (err) {
        return callBack(err, null);
      }
      return callBack(null, results);
    }
  )
}

export function updateCheckInService(data, id, callBack) {
  pool.query(
    `UPDATE check_in_records SET latitude = $1, longitude = $2, datetime = $3, imageurl = $4
    WHERE id = $5
    `,
    [
      data.latitude,
      data.longitude,
      data.datetime,
      data.imageUrl,
      id
    ],
    (err, results) => {
      if (err) {
        return callBack(err, null);
      }
      return callBack(null, results);
    }
  )
}

export function checkCheckOutExistService(data, callBack) {
  pool.query(
    `SELECT * FROM check_out_records WHERE datetime::date = now()::date LIMIT 1`,
    (err, results) => {
      if (err) {
        return callBack(err, null);
      }
      return callBack(null, results);
    }
  )
}

export function createCheckOutService(data, callBack) {
  pool.query(
    `INSERT INTO check_out_records (latitude, longitude, datetime, imageurl) VALUES ($1, $2, $3, $4)`,
    [
      data.latitude,
      data.longitude,
      data.datetime,
      data.imageUrl
    ],
    (err, results) => {
      if (err) {
        return callBack(err, null);
      }
      return callBack(null, results);
    }
  )
}

export function updateCheckOutService(data, id, callBack) {
  pool.query(
    `UPDATE check_out_records SET latitude = $1, longitude = $2, datetime = $3, imageurl = $4
    WHERE id = $5
    `,
    [
      data.latitude,
      data.longitude,
      data.datetime,
      data.imageUrl,
      id
    ],
    (err, results) => {
      if (err) {
        return callBack(err, null);
      }
      return callBack(null, results);
    }
  )
}


export function findCheckHistoryService(data, callBack) {
  pool.query(
    `(SELECT * FROM check_in_records WHERE datetime::date = $1)
    UNION ALL
    (SELECT * FROM check_out_records WHERE datetime::date = $1)
    `,
    [
      data.datetime
    ],
    (err, results) => {
      if (err) {
        return callBack(err, null);
      }
      return callBack(null, results);
    }
  )
}
