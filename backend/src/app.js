import express from "express";
import { createPool } from "mariadb";
import personRoute from "./routes/person.js";

const PORT = 8080;

const app = express();


app.get("/", (req, res) => {
    console.log("Hello World!");
    res.send("Hello World!");
});

app.use("/person", personRoute);


app.listen(PORT, () => {
    console.log("Server is running on port " + PORT);
});