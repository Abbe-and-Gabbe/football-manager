import express from "express";
import cors from "cors";
import jwt from "jsonwebtoken";
const ACCESS_TOKEN_SECRET = "ablkdjflksjdflsdjf"

// Route imports
import personRouter from "./routes/person.js";
import teamRouter from "./routes/team.js";
import clubRouter from "./routes/club.js";
import newsRouter from "./routes/news.js";

import authRouter from "./routes/auth.js";

import { request } from "https";


const PORT = 8080;

const app = express();

app.use(cors({
    origin: "*",
}));

app.use(function(request, response, next){
    response.set("Access-Control-Allow-Origin", "*")
	response.set("Access-Control-Allow-Methods", "*")
	response.set("Access-Control-Allow-Headers", "*")
	response.set("Access-Control-Expose-Headers", "*")
    next()
})

app.use(express.json())


app.use(express.urlencoded())

app.get("/", (req, res) => {
    res.send("Hello World!");
});

// Routes
app.use("/person", personRouter);
app.use("/team", teamRouter)
app.use("/club", clubRouter)
app.use("/news", newsRouter)


app.use("/auth", authRouter)

//login
/*
app.post('/tokens', function(request, response){
    const grantType = request.body.grant_type
    const username = request.body.username
    const password = request.body.password

    if(grantType != "password"){
        response.status(400).json({error: "unsupported_grant_type"})
        return
    }
    
    //Have a invalid request check 

  

    //Replace with username and password from DB 
    if(username == "abc" && password == "abc123"){
        const payload = {
            isLoggedIn: true,
        }
        jwt.sign(payload, ACCESS_TOKEN_SECRET, function(error, accessToken){
            if(error){
                response.status(500).end()
            }else{
                response.status(200).json({
                    access_token: accessToken,
                    type: "bearer"
                })
            }
        })
    }else{
        response.status(400).json({error: "invalid_grant"})
    }


})
*/
app.listen(PORT, () => {
    console.log("Server is running on port " + PORT);
});