import { Router } from "express";
import { pool } from "../db.js"

const router = Router();

router.get("/", async (req, res) => {
    let getAllTeamsData = {};

    try {
        const connection = await pool.getConnection();
        const query = `
        SELECT Team.id, Team.teamName, Team.clubId, Club.clubName FROM Team
        JOIN Club ON Team.clubId = Club.id
        `;

        getAllTeamsData = await connection.query(query);
        connection.release();
        res.send(getAllTeamsData);
    } catch (err) {
        res.status(404);
        res.send({
            errorCode: "not_found",
            errorMessage: "Teams not found"
        });
    }
});



router.get("/:id", async (req, res) => {
    let specificTeamData = {};

    try {
        const connection = await pool.getConnection();
        const query = "SELECT * FROM Team WHERE id = ?";
        const team = await connection.query(query, [req.params.id]);
        specificTeamData = team;

        connection.release();
        if (team.length === 0) {
            res.status(404);
            res.send({
                errorCode: "not_found",
                errorMessage: "Team not found"
            });
        } else {
            res.status(200).json(specificTeamData);
        }
    } catch (err) {
        res.status(500);
        res.send({
            errorCode: "internal_server_error",
            errorMessage: "Failed to fetch team"
        });
    }
});


router.get("/:id/players", async (req, res) => {
    let playersForSpecificTeamData = {};

    try {
        const connection = await pool.getConnection();
        const query = `
            SELECT *
            FROM person
            WHERE id IN (SELECT personId FROM teamPlayer WHERE teamId = ?)
        `;

        playersForSpecificTeamData = await connection.query(query, [req.params.id]);

        connection.release();
        res.send(playersForSpecificTeamData);
    } catch (err) {
        res.status(500);
        res.send({
            errorCode: "internal_server_error",
            errorMessage: "Failed to fetch players for specific team"
        });
    }
});




router.get("/:id/staff", async (req, res) => {
    let staffForSpecificTeamData = {};

    try {
        const connection = await pool.getConnection();
        const query = `
            SELECT * FROM person
            JOIN teamStaff ON person.id = teamStaff.personId
            WHERE teamStaff.teamId = ?
        `;

        staffForSpecificTeamData = await connection.query(query, [req.params.id]);

        connection.release();
        res.send(staffForSpecificTeamData);
    } catch (err) {
        res.status(500);
        res.send({
            errorCode: "internal_server_error",
            errorMessage: "Failed to fetch staff for specific team"
        });
    }
});




router.get("/:id/news", async (req, res) => {

    // Try to parse the limit parameter, if it is not a number, set it to 10
    let limit = parseInt(req.query.limit);
    if (isNaN(limit)) {
        limit = 10;
    }

    console.log(limit);
    let newsForSpecificTeamData = {}
    try {
        const connection = await pool.getConnection();
        const query = `
            SELECT news.id, news.title, news.content, news.published, person.firstName, person.lastName, person.id AS "personId" FROM news
            JOIN person ON news.personId = person.id
            WHERE news.teamId = ?
            ORDER BY news.published DESC
            LIMIT ?
        `;
        newsForSpecificTeamData = await connection.query(query, [req.params.id, limit]);
        connection.release();
        res.send(newsForSpecificTeamData);
    } catch (err) {
        res.status(500);
        res.send({
            errorCode: "not_found",
            errorMessage: "Team not found"
        })
    }
});


router.get("/:id/games", async (req, res) => {
    let getGamesForSpecificTeam = {}
    console.log(req.params.id);
    try {
        const connection = await pool.getConnection();


        const query = `
            SELECT game.id, game.homeScoreId, game.date, game.awayScoreId, TeamHome.teamName AS "homeTeam", TeamAway.teamName AS "awayTeam" FROM game	
            JOIN team AS TeamHome ON game.homeTeamId = TeamHome.id
            JOIN team AS TeamAway ON game.awayTeamId = TeamAway.id
            WHERE game.homeTeamId = ? OR game.awayTeamId = ?
            ORDER BY game.date DESC
        `;
        getGamesForSpecificTeam = await connection.query(query, [req.params.id, req.params.id]);


        connection.release();
        res.send(getGamesForSpecificTeam);
    } catch (err) {
        res.status(500);
        res.send({
            errorCode: "not_found",
            errorMessage: "Team not found"
        })
    }
});


router.get("/:id/activities", async (req, res) => {
    let activitiesForSpecificTeamData = {}
    try {
        const connection = await pool.getConnection();
        const query = `
            SELECT training.id, training.startDate, training.stopDate, team.teamName FROM training
            JOIN team ON training.teamId = team.id
            WHERE training.teamId = ?
            ORDER BY training.startDate DESC
        `;
        activitiesForSpecificTeamData = await connection.query(query, [req.params.id]);
        connection.release();
        res.send(activitiesForSpecificTeamData);
    } catch (err) {
        res.status(500);
        res.send({
            errorCode: "not_found",
            errorMessage: "Team not found"
        })
    }
});

router.post("/:id/add-news", async (req, res) => {
    console.log("POST /team/:id/add-news");

    const { title, content, personId } = req.body;

    const maxTitleLength = 20;
    const maxContentLength = 100;

    if (title.length > maxTitleLength || title.trim() === "") {
        res.status(400).json({
            error: "Invalid title",
            errorMessage: `Title must not exceed ${maxTitleLength} characters and must not be empty`,
        });
        return;
    }

    if (content.length > maxContentLength || content.trim() === "") {
        res.status(400).json({
            error: "Invalid content",
            errorMessage: `Content must not exceed ${maxContentLength} characters and must not be empty`,
        });
        return;
    }

    try {
        const connection = await pool.getConnection();
        const query = `
            INSERT INTO news (title, content, published, personId, teamId)
            VALUES (?, ?, ?, ?, ?)
        `;

        const published = new Date();

        await connection.query(query, [title, content, published, personId || 1, req.params.id]);
        connection.release();

        res.status(201).json({
            success: true,
            message: "News item added",
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({
            errorCode: "internal_server_error",
            errorMessage: "Failed to add news item",
        });
    }
});



router.post("/:id/invite", async (req, res) => {
    const teamId = req.params.id;
    const { email } = req.body;

    // Check if the user exists

    if (!await checkIfUserExist(email)) {
        res.status(400);
        res.send({
            errorCode: "user_not_found",
            errorMessage: "User not found"
        });
        return;
    } else {
        // Check if the user is already invited
        if (await checkIfUserIsInvited(teamId, email)) {
            res.status(400);
            res.send({
                errorCode: "already_invited",
                errorMessage: "User is already invited"
            });
            return;
        } else {
            // Add the user to the PlayerTeam table
            const connection = await pool.getConnection();
            const query = "INSERT INTO teamPlayer (teamId, personId) VALUES (?, (SELECT id FROM person WHERE email = ?))";

            connection.query(query, [teamId, email]);
            connection.release();
            res.send({
                success: true
            });
        }
    }
});

async function checkIfUserIsInvited(teamId, email) {
    console.log("teamId: " + teamId);
    console.log("email: " + email);
    const conn = await pool.getConnection();
    const query = "SELECT * FROM teamPlayer WHERE teamId = ? AND personId = (SELECT id FROM person WHERE email = ?)";

    const user = await conn.query(query, [teamId, email]);

    conn.release();

    if (user.length === 0) {
        return false;
    }
    return true;
}

async function checkIfUserExist(email) {

    const conn = await pool.getConnection();
    const query = "SELECT * FROM person WHERE email = ?";

    const user = await conn.query(query, [email]);

    conn.release();

    if (user.length === 0) {
        return false;
    }

    return true
}

export default router;