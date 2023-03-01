import express from "express";
import { createPool } from "mariadb";

const PORT = 8080;

const pool = createPool({
    host: "db",
    port: 3306,
    user: "root",
    password: "abc123",
    database: "Football-ManagerDB",
});

// pool on error
pool.on("error", function (err) {
    console.log("MariaDB connection error: " + err);
});

const app = express();


app.get("/", (req, res) => {
    console.log("Hello World!");
    res.send("Hello World!");
});

app.get("/person/:id", async (req, res) => {
    console.log("Get person with id: " + req.params.id);
    try {
        const connection = await pool.getConnection();
        const person = await connection.query(
            "SELECT * FROM Person WHERE id = ?",
            [req.params.id]
        );
        connection.release();
        res.send(person);
    } catch (err) {
        console.log(err);
    }
});

app.listen(PORT, () => {
    console.log("Server is running on port " + PORT);
});