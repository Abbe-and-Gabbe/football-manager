import express from "express";
import cors from "cors";
// Route imports
import personRouter from "./routes/person.js";
import teamRouter from "./routes/team.js";
import clubRouter from "./routes/club.js";

const PORT = 8080;

const app = express();

app.use(cors());

app.get("/", (req, res) => {
    res.send("Hello World!");
});

// Routes
app.use("/person", personRouter);
app.use("/team", teamRouter)
app.use("/club", clubRouter)


app.listen(PORT, () => {
    console.log("Server is running on port " + PORT);
});