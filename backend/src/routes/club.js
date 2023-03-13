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



export default router;