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
        console.log(err);
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
        console.log(err);
    }
});




export default router;