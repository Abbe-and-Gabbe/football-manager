import { Router } from "express";
import { pool } from "../db.js"

const router = Router();

// Returns all the clubs

router.get("/", async (req, res) => {
    console.log("GET /club");
    try {
        const conn = await pool.getConnection();
        const clubs = await conn.query("SELECT * FROM Club");
        console.log(clubs);
        res.json(clubs);
    } catch (err) {
        console.log(err);
        res.status(500).json({ message: err.message });
    }
});


// Returns a club with the given id

router.get("/:id", async (req, res) => {
    console.log("GET /club/:id");
    let data = {}
    try {
        const conn = await pool.getConnection();
        const club = await conn.query("SELECT * FROM Club WHERE id = ?", [req.params.id]);
        data.club = club[0];
        const teams = await conn.query("SELECT * FROM Team WHERE clubId = ?", [req.params.id]);
        data.teams = teams;
        console.log(data)
        res.json(data);
    } catch (err) {
        console.log(err);
        res.status(500).json({ message: err.message, errorCode: err.errno });
    }
});





// Get the news for all the teams in a club
router.get("/:id/news", async (req, res) => {
    try {
        const conn = await pool.getConnection();
        const news = await conn.query(`
            SELECT News.id,title, content, published, personId, Person.firstName, Person.lastName, Team.teamName FROM Team
            JOIN News ON Team.id = News.teamId
            JOIN Person ON Person.id = News.personId
            WHERE Team.clubId = ?
            ORDER BY published DESC
        `, [req.params.id]);
        console.log(news)
        res.json(news);
    } catch (err) {
        console.log(err)
        res.status(500).json({ message: err.message });
    }
});

// Get the upcoming matches for all the teams in a club

router.get("/:id/games", async (req, res) => {
    try {
        const conn = await pool.getConnection();
        const games = await conn.query(`
            SELECT * FROM Game
            WHERE (homeTeam IN (SELECT id FROM Team WHERE clubId = ?) OR awayTeam IN (SELECT id FROM Team WHERE clubId = ?))
            ORDER BY date ASC
        `, [req.params.id, req.params.id]);
        const homeTeam = await conn.query(`
            SELECT id, teamName FROM Team
            WHERE clubId = ?
        `, [req.params.id]);
        const awayTeam = await conn.query(`

            SELECT id, teamName FROM Team
            WHERE clubId = ?
        `, [req.params.id]);
        games.forEach(game => {
            homeTeam.forEach(team => {
                if (game.homeTeam === team.id) {
                    game.homeTeam = team.teamName;
                }
            });
            awayTeam.forEach(team => {
                if (game.awayTeam === team.id) {
                    game.awayTeam = team.teamName;
                }
            });
        });

        res.json(games);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});

// Get upcoming activities for all the teams in a club

router.get("/:id/activities", async (req, res) => {
    try {
        const conn = await pool.getConnection();
        const activities = await conn.query(`
            SELECT teamId, date, Team.teamName FROM Training
            JOIN Team ON Team.id = Training.teamId
            ORDER BY date ASC
        `, [req.params.id]);

        res.json(activities);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});

// Add new club

router.post("/", async (req, res) => {
    let clubName = req.query.clubName.toString();
    try {
        const conn = await pool.getConnection();
        const result = await conn.query("INSERT INTO Club (clubName) VALUES (?)", [clubName]);
        console.log(result);
        res.json("Clubb added successfully");
    } catch (err) {
        res.status(500).json({ message: "Something went wrong", errorCode: err.errno });
    }
});


router.post("/:id/news", async (req, res) => {
  let title = req.query.title.toString();
  let content = req.query.content.toString();
  let datetime = req.query.content.toString();
  try {
    const conn = await console.query("INSERT INTO News (title, content, datetime) VALUES (?, ?, ?)", [title, content, datetime])
    res.json("news added successfully");
  } catch (err) {
    res.status(500).json({message: "Something went wrong", errorCode: err.errno});
  }



});


export default router;