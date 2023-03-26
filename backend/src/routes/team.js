import { Router } from "express";
import { pool } from "../db.js"

const router = Router();

// Get all teams
router.get("/", async (req, res) => {
    console.log("Test")
    let data = {}
    try {
        const connection = await pool.getConnection();
        const query = `
        SELECT Team.id, Team.teamName, Team.clubId, Club.clubName FROM Team
        JOIN Club ON Team.clubId = Club.id
        `;

        data = await connection.query(query);
        connection.release();
        res.send(data);
    } catch (err) {
        res.status(500);
        res.send({
            errorCode: "not_found",
            errorMessage: "Teams not found"
        })
    }
});

// Returns the team with the given id, the data is joined with the persons
// connected to the team, players and staff.

router.get("/:id", async (req, res) => {
    let data = {}
    try {
        const connection = await pool.getConnection();
        const query = "SELECT * FROM Team WHERE id = ?"
        const team = await connection.query(query, [req.params.id]);
        data = team;
        // Hide all passwords
        // TODO: This should be done in the database
        data.forEach(person => {
            person.password = "*********";
        });

        connection.release();
        res.send(data);
    } catch (err) {
        res.status(500);
        res.send({
            errorCode: "not_found",
            errorMessage: "Team not found"
        })
    }
})

// Returns all the players in the team with the given id

router.get("/:id/players", async (req, res) => {
    let data = {}
    try {
        const connection = await pool.getConnection();
        const query = "SELECT * FROM Person WHERE id IN (SELECT PersonId FROM TeamPlayer WHERE TeamId = ?)";

        data = await connection.query(query, [req.params.id]);
        // Hide all passwords

        data.forEach(person => {
            person.password = "*********";
        });

        connection.release();
        res.send(data);
    } catch (err) {
        res.status(500);
        res.send({
            errorCode: "not_found",
            errorMessage: "Team not found"
        })
    }
});

// Returns all the staff in the team with the given id
// TODO: Add documentation

router.get("/:id/staff", async (req, res) => {
    let data = {}
    try {
        const connection = await pool.getConnection();
        const query = `
            SELECT * FROM Person
            JOIN TeamStaff ON Person.id = TeamStaff.PersonId
            WHERE TeamStaff.TeamId = ?
        `;

        data = await connection.query(query, [req.params.id]);
        // Hide all passwords

        data.forEach(person => {
            person.password = "*********";
        });

        connection.release();
        res.send(data);
    } catch (err) {
        res.status(500);
        res.send({
            errorCode: "not_found",
            errorMessage: "Team not found"
        })
    }
});

// Returns all the news items for the team with the given id
// TODO: Add documentation

router.get("/:id/news", async (req, res) => {

    // Try to parse the limit parameter, if it is not a number, set it to 10
    let limit = parseInt(req.query.limit);
    if (isNaN(limit)) {
        limit = 10;
    }


    console.log(limit);
    let data = {}
    try {
        const connection = await pool.getConnection();
        const query = `
            SELECT News.id, News.title, News.content, News.published, Person.firstName, Person.lastName, Person.id AS "PersonId" FROM News
            JOIN Person ON News.PersonId = Person.id
            WHERE News.TeamId = ?
            ORDER BY News.published DESC
            LIMIT ?
        `;
        data = await connection.query(query, [req.params.id, limit]);
        connection.release();
        res.send(data);
    } catch (err) {
        res.status(500);
        res.send({
            errorCode: "not_found",
            errorMessage: "Team not found"
        })
    }
});

// Returns all the matches for the team with the given id

router.get("/:id/games", async (req, res) => {
    let data = {}
    console.log(req.params.id);
    try {
        const connection = await pool.getConnection();
        // Get all games, then set teamHome and teamAway to the
        // team name instead of the id

        const query = `
            SELECT Game.id, Game.homeScore, Game.date, Game.awayScore, TeamHome.teamName AS "homeTeam", TeamAway.teamName AS "awayTeam" FROM Game	
            JOIN Team AS TeamHome ON Game.homeTeam = TeamHome.id
            JOIN Team AS TeamAway ON Game.awayTeam = TeamAway.id
            WHERE Game.homeTeam = ? OR Game.awayTeam = ?
            ORDER BY Game.date DESC
        `;
        data = await connection.query(query, [req.params.id, req.params.id]);


        connection.release();
        res.send(data);
    } catch (err) {
        res.status(500);
        res.send({
            errorCode: "not_found",
            errorMessage: "Team not found"
        })
    }
});

// Returns all trainings for the team with the given id

router.get("/:id/activities", async (req, res) => {
    let data = {}
    try {
        const connection = await pool.getConnection();
        const query = `
            SELECT Training.id, Training.startDate, Training.stopDate, Team.teamName FROM Training
            JOIN Team ON Training.TeamId = Team.id
            WHERE Training.TeamId = ?
            ORDER BY Training.startDate DESC
        `;
        data = await connection.query(query, [req.params.id]);
        connection.release();
        res.send(data);
    } catch (err) {
        res.status(500);
        res.send({
            errorCode: "not_found",
            errorMessage: "Team not found"
        })
    }
});




export default router;