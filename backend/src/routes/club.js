import { Router } from "express";
import { pool } from "../db.js"

const router = Router();

// Returns all the clubs

router.get("/", async (req, res) => {
    try {
        const conn = await pool.getConnection();
        const clubs = await conn.query("SELECT * FROM Club");
        res.json(clubs);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});

// Returns a club with the given id

router.get("/:id", async (req, res) => {
    let data = {}
    try {
        const conn = await pool.getConnection();
        const club = await conn.query("SELECT * FROM Club WHERE id = ?", [req.params.id]);
        data.club = club[0];
        const teams = await conn.query("SELECT * FROM Team WHERE clubId = ?", [req.params.id]);
        data.teams = teams;
        res.json(data);
    } catch (err) {
        res.status(500).json({ message: err.message, errorCode: err.errno });
    }
});

// Get the news for all the teams in a club

router.get("/:id/news", async (req, res) => {
    try {
        const conn = await pool.getConnection();
        const news = await conn.query(`
            SELECT title, content, published, personId, Person.firstName, Person.lastName, Team.teamName FROM Team
            JOIN News ON Team.id = News.teamId
            JOIN Person ON Person.id = News.personId
            WHERE Team.clubId = ?
            GROUP BY News.id
        `, [req.params.id]);
        res.json(news);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});




export default router;