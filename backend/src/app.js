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
    let data = {}
    console.log("Get person with id: " + req.params.id);
    try {
        const connection = await pool.getConnection();
        // Select the person with the id and join PlayerTeam and Team tables
        const personQuery = "SELECT * FROM Person WHERE id = ?";
        const person = await connection.query(personQuery, [req.params.id]);
        data = person[0];
        data.password = "*********";
        // Select the teams the person is in
        const playerTeamsQuery = `
                        SELECT Team.id, Team.teamName, Team.clubId FROM Team 
                        JOIN TeamPlayer ON Team.id = TeamPlayer.teamId 
                        JOIN Club ON Team.clubId = Club.id
                        WHERE TeamPlayer.PersonId = ?
                        `

        // Get the teams where the person is a player
        const playerTeams = await connection.query(playerTeamsQuery, [req.params.id]);
        data.playerTeams = playerTeams;

        // Get the teams where the person is a staff member
        const staffTeamsQuery = `
                        SELECT Team.id, Team.teamName, Team.clubId, TeamStaff.role FROM Team
                        JOIN TeamStaff ON Team.id = TeamStaff.teamId
                        JOIN Club ON Team.clubId = Club.id
                        WHERE TeamStaff.PersonId = ?
                        `
        const staffTeams = await connection.query(staffTeamsQuery, [req.params.id]);

        data.staffTeams = staffTeams;

        connection.release();
        res.send(data);
    } catch (err) {
        res.send({
            errorCode: "not_found",
            errorMessage: "Person not found"
        })
    }
});

app.listen(PORT, () => {
    console.log("Server is running on port " + PORT);
});