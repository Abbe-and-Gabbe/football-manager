import { Router } from "express";
import { pool } from "../db.js"

const router = Router();

// Get the news for every team the person is in
// id is the id of the person logged in

router.get("/:id/news", async(req, res) => {
    let id = req.params.id;
    let data = {}
    console.log("Get news for person with id: " + id);
    try {
        const connection = await pool.getConnection();
        const query = `
                        SELECT n.id, n.personId, n.title, n.content, n.published, n.teamId, Person.firstName, Person.lastName FROM News as n
                        JOIN TeamPlayer ON n.teamId = TeamPlayer.teamId
                        JOIN TeamStaff ON n.teamId = TeamStaff.teamId
                        JOIN Person ON n.personId = Person.id
                        WHERE TeamPlayer.personId = ?
                        OR TeamStaff.personId = ?
                        GROUP BY n.id
                        `
        const news = await connection.query(query, [id, id]);
        data = news;
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

router.get("/:id/news/:newsId", async (req, res) => {
  let id = req.params.id;
  let newsId = req.params.newsId;
  let data = {};
    try {
    const connection = await pool.getConnection();
    const query = `
      SELECT n.id, n.personId, n.title, n.content, n.published, n.teamId, Person.firstName, Person.lastName FROM News as n
      JOIN TeamPlayer ON n.teamId = TeamPlayer.teamId
      JOIN TeamStaff ON n.teamId = TeamStaff.teamId
      JOIN Person ON n.personId = Person.id
      WHERE (TeamPlayer.personId = ? OR TeamStaff.personId = ?)
      AND n.id = ?
      GROUP BY n.id
    `;
    const news = await connection.query(query, [id, id, newsId]);
    data = news[0];
    connection.release();
    res.send(data);
  } catch (err) {
    console.error(err);
    res.status(404);
    res.send({
      errorCode: "not_found",
      errorMessage: "News article not found"
    });
  }
});


router.post("/:id/news", async (req, res) => {
  let id = req.params.id;
  let newsData = req.body;
  try {
    const connection = await pool.getConnection();
    const query = `
      INSERT INTO News (personId, teamId, title, content, published)
      VALUES (?, ?, ?, ?, ?)
    `;
    const result = await connection.query(query, [id, newsData.teamId, newsData.title, newsData.content, newsData.published]);
    const newsId = result.insertId;
    connection.release();
    res.send({
      id: newsId,
      message: "News article created successfully"
    });
  } catch (err) {
    console.error(err);
    res.status(500);
    res.send({
      errorCode: "internal_server_error",
      errorMessage: "Failed to create news article"
    });
  }
});

router.put("/:id/news/:newsId", async (req, res) => {
  let id = req.params.id;
  let newsId = req.params.newsId;
  let newsData = req.body;
  console.log(`Edit news article ${newsId} for person with id: ${id}`);
  try {
    const connection = await pool.getConnection();
    const query = `
      UPDATE News
      SET teamId = ?, title = ?, content = ?, published = ?
      WHERE id = ?
      AND personId = ?
    `;
    const result = await connection.query(query, [newsData.teamId, newsData.title, newsData.content, newsData.published, newsId, id]);
    connection.release();
    if (result.affectedRows === 0) {
      res.status(404);
      res.send({
        errorCode: "not_found",
        errorMessage: "News article not found"
      });
    } else {
      res.send({
        message: "News article updated successfully"
      });
    }
  } catch (err) {
    console.error(err);
    res.status(500);
    res.send({
      errorCode: "internal_server_error",
      errorMessage: "Failed to update news article"
    });
  }
});


router.delete("/:id/news/:newsId", async (req, res) => {
let id = req.params.id;
let newsId = req.params.newsId;
try {
const connection = await pool.getConnection();
const query = 'DELETE FROM News WHERE id = ? AND personId = ?' 
const result = await connection.query(query, [newsId, id]);
connection.release();
if (result.affectedRows === 0) {
res.status(404);
res.send({
errorCode: "not_found",
errorMessage: "News article not found"
});
} else {
res.send({
message: "News article deleted successfully"
});
}
} catch (err) {
console.error(err);
res.status(500);
res.send({
errorCode: "internal_server_error",
errorMessage: "Failed to delete news article"
});
}
});

router.get("/:id/activites", async (req, res) => {
    let id = req.params.id;
    let data = {}
    console.log("Get activities for person with id: " + id);
    try {
        const connection = await pool.getConnection();
        const query = `
                        SELECT id, startDate, stopDate, "Training" as type FROM Training
                        WHERE teamId IN (
                            SELECT teamId FROM TeamPlayer
                            WHERE personId = ?
                        )
                        OR teamId IN (
                            SELECT teamId FROM TeamStaff
                            WHERE personId = ?
                        )
                        ORDER BY startDate DESC
                        `
        const activities = await connection.query(query, [id, id]);

        const queryGames = `
                            SELECT id, homeTeam, awayTeam, homeScore, awayScore, date as startDate, "Game" as type FROM Game
                            WHERE homeTeam IN (
                                SELECT teamId FROM TeamPlayer
                                WHERE personId = ?
                            )
                            OR awayTeam IN (
                                SELECT teamId FROM TeamPlayer
                                WHERE personId = ?
                            )
                            OR homeTeam IN (
                                SELECT teamId FROM TeamStaff
                                WHERE personId = ?
                            )
                            OR awayTeam IN (
                                SELECT teamId FROM TeamStaff
                                WHERE personId = ?
                            )
                            ORDER BY date DESC
                            `

        const games = await connection.query(queryGames, [id, id, id, id]);

        data = activities.concat(games);

        // Sort the array by date acsending
        data.sort((a, b) => {
            return new Date(a.startDate) - new Date(b.startDate);
        });

        // Only return the 10 latest activities
        data = data.slice(0, 10);

        // Only show activities where the date is in the future
        data = data.filter((activity) => {
            return new Date(activity.startDate) > new Date();
        });

        connection.release();
        res.send(data);
    } catch (err) {
        console.log(err);
        res.status(404);
        res.send({
            errorCode: "not_found",
            errorMessage: "Person not found"
        })
    }
});




// Return a person with the given id, the data is joined with the teams
// where the person has a role, both player and staff roles. 

router.get("/:id", async(req, res) => {
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



// Gets all persons from the database, no joins are made
// This will probably only be useful for admins

router.get("/", async(req, res) => {
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
        res.status(500);
        res.send({
            errorCode: "server_error",
        })
    }
});

export default router;