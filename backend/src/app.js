import express from "express";
import { createPool } from "mariadb";

// Route imports
import personRouter from "./routes/person.js";
import teamRouter from "./routes/team.js";

const PORT = 8080;

const app = express();

app.get("/", (req, res) => {
    res.send("Hello World!");
});

// Routes
app.use("/person", personRouter);
app.use("/team", teamRouter)


app.listen(PORT, () => {
    console.log("Server is running on port " + PORT);
});