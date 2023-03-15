import express from "express";
import cors from "cors";
// Route imports
import personRouter from "./routes/person.js";
import teamRouter from "./routes/team.js";
import clubRouter from "./routes/club.js";
import { request } from "https";

const PORT = 8080;

const app = express();

app.use(cors());

app.use(express.urlencoded())

app.get("/", (req, res) => {
    res.send("Hello World!");
});

// Routes
app.use("/person", personRouter);
app.use("/team", teamRouter)
app.use("/club", clubRouter)

//login
app.post('/tokens', function(request, response){
    const grantType = request.body.grant_type
    const username = request.body.username
    const password = request.body.password
})

app.listen(PORT, () => {
    console.log("Server is running on port " + PORT);
});