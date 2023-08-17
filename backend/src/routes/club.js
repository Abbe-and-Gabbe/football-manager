import { Router } from "express";
import { pool } from "../db.js";

const router = Router();

router.get("/", async (req, res) => {
  console.log("GET /club");
  try {
    const conn = await pool.getConnection();
    const clubs = await conn.query("SELECT * FROM club");
    console.log(clubs);
    res.json(clubs);
  } catch (err) {
    console.log(err);
    res.status(500).json({ message: err.message });
  }
});

router.get("/:id", async (req, res) => {
  console.log("GET /club/:id");
  let clubData = {};
  try {
    const conn = await pool.getConnection();

    const club = await conn.query("SELECT * FROM club WHERE id = ?", [
      req.params.id,
    ]);
    if (club.length === 0) {
      return res.status(404).json({ message: "Club not found" });
    }
    clubData.club = club[0];

    const teams = await conn.query("SELECT * FROM team WHERE clubId = ?", [
      req.params.id,
    ]);
    clubData.teams = teams;

    console.log(clubData);
    res.json(clubData);
  } catch (err) {
    console.log(err);

    res.status(500).json({
      message: "An internal server error occurred. Please try again later.",
    });
  }
});




router.get("/:id/teams", async (req, res) => {
  console.log("GET /club/:id/teams");
  let teamsData = {};
  try {
    const conn = await pool.getConnection();
    const teams = await conn.query("SELECT * FROM team WHERE clubId = ?", [
      req.params.id,
    ]);

    if (teams.length === 0) {
      return res.status(404).json({ message: "No teams found for this club." });
    }

    teamsData.teams = teams;
    console.log(teamsData);
    res.json(teamsData);
  } catch (err) {
    console.log(err);

    res.status(500).json({
      message: "An internal server error occurred while fetching teams.",
    });
  }
});


router.get("/:id/news", async (req, res) => {
  try {
    const conn = await pool.getConnection();
    const news = await conn.query(
      `
        SELECT news.id, title, content, published, personId, person.firstName, person.lastName, team.teamName FROM team
        JOIN news ON team.id = news.teamId
        JOIN person ON person.id = news.personId
        WHERE team.clubId = ?
        ORDER BY published DESC
      `,
      [req.params.id]
    );

    if (news.length === 0) {
      return res.status(404).json({ message: "No news articles found for this club." });
    }

    console.log(news);
    res.json(news);
  } catch (err) {
    console.log(err);

    res.status(500).json({
      message: "An internal server error occurred while fetching news articles.",
    });
  }
});


router.get("/:id/contact", async (req, res) => {
  console.log("/:id/contact");
  try {
    const connection = await pool.getConnection();
    const query = `
      SELECT person.firstName, person.lastName, person.email, person.phoneNumber, team.teamName, teamStaff.role
      FROM person
      JOIN teamStaff ON person.id = teamStaff.personId
      JOIN team ON team.id = teamStaff.teamId
      WHERE team.id = ? AND teamStaff.role = "Head Coach"
    `;

    const data = await connection.query(query, [req.params.id]);

    connection.release();

    // Check if any contact persons were found
    if (data.length === 0) {
      return res.status(404).json({ message: "No contact person (Head Coach) found for this team." });
    }

    res.json(data);
  } catch (err) {
    console.log(err);
    res.status(500).json({
      errorCode: "internal_error",
      errorMessage: "An internal server error occurred while fetching contact person.",
    });
  }
});


router.get("/:id/games", async (req, res) => {
  try {
    const conn = await pool.getConnection();
    const games = await conn.query(
      `
            SELECT * FROM game
            WHERE (homeTeamId IN (SELECT id FROM team WHERE clubId = ?) OR awayTeamId IN (SELECT id FROM team WHERE clubId = ?))
            ORDER BY date ASC
        `,
      [req.params.id, req.params.id]
    );
    const homeTeam = await conn.query(
      `
            SELECT id, teamName FROM team
            WHERE clubId = ?
        `,
      [req.params.id]
    );
    const awayTeam = await conn.query(
      `

            SELECT id, teamName FROM team
            WHERE clubId = ?
        `,
      [req.params.id]
    );
    games.forEach((game) => {
      homeTeam.forEach((team) => {
        if (game.homeTeam === team.id) {
          game.homeTeam = team.teamName;
        }
      });
      awayTeam.forEach((team) => {
        if (game.awayTeam === team.id) {
          game.awayTeam = team.teamName;
        }
      });
    });

    res.json(games);
  } catch (err) {
    res.status(500).json({ message: "An internal server error occurred while fetching games." });
  }
});


router.get("/:id/activities", async (req, res) => {
  try {
    const conn = await pool.getConnection();
    const activities = await conn.query(`
            SELECT teamId, startDate, stopDate, team.teamName FROM training
            JOIN team ON team.id = training.teamId
            JOIN club ON club.id = team.clubId
            WHERE club.id = ?
            ORDER BY startDate ASC
        `, [req.params.id]);

    res.status(200).json(activities);
  } catch (err) {
    res.status(500).json({ error: "Could not fetch activities" });
  }
});





router.post("/", async (req, res) => {
  let clubName = req.query.clubName.toString();
  try {
    const conn = await pool.getConnection();
    const result = await conn.query("INSERT INTO club (clubName) VALUES (?)", [
      clubName,
    ]);
    console.log(result);
    res.status(201).json("Club added successfully");
  } catch (err) {
    res
      .status(500)
      .json({ error: "Something went wrong", errorCode: err.errno });
  }
});


export default router;
