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
        const query = "SELECT * FROM Person WHERE id IN (SELECT PersonId FROM TeamPlayer WHERE TeamId = ?)";
        const persons = await connection.query(query, [req.params.id]);
        data = persons;
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
    let data = {}
    try {
        const connection = await pool.getConnection();
        const query = `
            SELECT News.id, News.title, News.content, News.published, Person.firstName, Person.lastName, Person.id AS "PersonId" FROM News
            JOIN Person ON News.PersonId = Person.id
            WHERE News.TeamId = ?
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