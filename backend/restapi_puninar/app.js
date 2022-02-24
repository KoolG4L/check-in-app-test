
import router from "./config/routes.js";
import express from "express";

const app_port = 8080;
const app = express();

app.use(express.json());
app.use('/api', router);


//localhost:8080
app.listen(app_port, () => {
    console.log("Server up and running on PORT : ", app_port);
  });
