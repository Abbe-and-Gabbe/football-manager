import { Router } from "express";
import { pool } from "../db.js"

const router = Router();

router.get("/:id", async (req, res) => {
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
                        SELECT Team.id, Team.teamName, Team.clubId, Club.clubName FROM Team 
                        JOIN TeamPlayer ON Team.id = TeamPlayer.teamId 
                        JOIN Club ON Team.clubId = Club.id
                        WHERE TeamPlayer.PersonId = ?
                        `

        // Get the teams where the person is a player
        const playerTeams = await connection.query(playerTeamsQuery, [req.params.id]);
        data.playerTeams = playerTeams;

        // Get the teams where the person is a staff member
        const staffTeamsQuery = `
                        SELECT Team.id, Team.teamName, Team.clubId, TeamStaff.role, Club.clubName FROM Team
                        JOIN TeamStaff ON Team.id = TeamStaff.teamId
                        JOIN Club ON Team.clubId = Club.id
                        WHERE TeamStaff.PersonId = ?
                        `
        const staffTeams = await connection.query(staffTeamsQuery, [req.params.id]);

        data.staffTeams = staffTeams;

        connection.release();
        res.send(data);
    } catch (err) {
        res.status(404);
        res.send({
            errorCode: "not_found",
            errorMessage: "Person not found"
        })
    }
});

router.get("/", async (req, res) => {
    let data = {}
    console.log("Get all persons");
    try {
        const connection = await pool.getConnection();
        const query = "SELECT * FROM Person";
        const persons = await connection.query(query);
        data = persons;
        connection.release();
        res.send(data);
    } catch (err) {
        res.status(404);
        res.send({
            errorCode: "not_found",
            errorMessage: "Persons not found"
        })
    }
});

export default router;