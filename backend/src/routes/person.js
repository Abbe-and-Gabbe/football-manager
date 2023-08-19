import { Router } from "express";
import { pool } from "../db.js";

const router = Router();

// Get the news for every team the person is in
// id is the id of the person logged in

router.get("/:id/news", async (req, res) => {

    let id = req.params.id;
    let newsForSpecificPersonIdData = {}
    console.log("Get news for person with id: " + id);
    try {
        const connection = await pool.getConnection();
        const query = `
                        SELECT n.id, n.personId, n.title, n.content, n.published, n.teamId, Person.firstName, Person.lastName FROM news as n
                        JOIN teamPlayer ON n.teamId = teamPlayer.teamId
                        JOIN teamStaff ON n.teamId = teamStaff.teamId
                        JOIN person ON n.personId = person.id
                        WHERE teamPlayer.personId = ?
                        OR teamStaff.personId = ?
                        GROUP BY n.id
                        `;
        const news = await connection.query(query, [id, id]);
        newsForSpecificPersonIdData = news;
        connection.release();
        res.send(newsForSpecificPersonIdData);
    } catch (err) {
        res.status(404);
        res.send({
            errorCode: "not_found",
            errorMessage: "Person not found",
        });
    }
});



router.get("/:id/activites", async (req, res) => {
    let id = req.params.id;
    let activitesForSpecificPersonIdData = {};
    console.log("Get activities for person with id: " + id);
    try {
        const connection = await pool.getConnection();
        const query = `
                        SELECT id, startDate, stopDate, "training" as type FROM training
                        WHERE teamId IN (
                            SELECT teamId FROM teamPlayer
                            WHERE personId = ?
                        )
                        OR teamId IN (
                            SELECT teamId FROM teamStaff
                            WHERE personId = ?
                        )
                        ORDER BY startDate DESC
                        `;
        const activities = await connection.query(query, [id, id]);

        const queryGames = `
                            SELECT id, homeTeamId, awayTeamId, homeScoreId, awayScoreId, date as startDate, "game" as type FROM game
                            WHERE homeTeamId IN (
                                SELECT teamId FROM teamPlayer
                                WHERE personId = ?
                            )
                            OR awayTeamId IN (
                                SELECT teamId FROM teamPlayer
                                WHERE personId = ?
                            )
                            OR homeTeamId IN (
                                SELECT teamId FROM teamStaff
                                WHERE personId = ?
                            )
                            OR awayTeamId IN (
                                SELECT teamId FROM teamStaff
                                WHERE personId = ?
                            )
                            ORDER BY date DESC
                            `;

        const games = await connection.query(queryGames, [id, id, id, id]);

        activitesForSpecificPersonIdData = activities.concat(games);

        // Sort the array by date acsending
        data.sort((a, b) => {
            return new Date(a.startDate) - new Date(b.startDate);
        });

        // Only return the 10 latest activities
        activitesForSpecificPersonIdData = data.slice(0, 10);

        // Only show activities where the date is in the future
        // data = data.filter((activity) => {
        //   return new Date(activity.startDate) > new Date();
        // });

        connection.release();
        res.send(activitesForSpecificPersonIdData);
    } catch (err) {
        console.log(err);
        res.status(404);
        res.send({
            errorCode: "not_found",
            errorMessage: "Person not found",
        });
    }
});

// Return a person with the given id, the data is joined with the teams
// where the person has a role, both player and staff roles. 

router.get("/:id", async (req, res) => {
    let personConnectedWithATeams = {};
    console.log("Get person with id: " + req.params.id);
    try {
        const connection = await pool.getConnection();
        // Select the person with the id and join PlayerTeam and Team tables
        const personQuery = "SELECT * FROM person WHERE id = ?";
        const person = await connection.query(personQuery, [req.params.id]);
        personConnectedWithATeams = person[0];
        personConnectedWithATeams.password = "*********";
        // Select the teams the person is in
        const playerTeamsQuery = `
                SELECT team.id, team.teamName, team.clubId, club.clubName FROM team
                JOIN teamPlayer ON team.id = teamPlayer.teamId
                JOIN club ON team.clubId = club.id
                WHERE teamPlayer.personId = ?
                    `;

        // Get the teams where the person is a player
        const playerTeams = await connection.query(playerTeamsQuery, [
            req.params.id,
        ]);
        personConnectedWithATeams.playerTeams = playerTeams;

        // Get the teams where the person is a staff member
        const staffTeamsQuery = `
                SELECT team.id, team.teamName, team.clubId, teamStaff.role, club.clubName FROM team
                JOIN teamStaff ON team.id = teamStaff.teamId
                JOIN club ON team.clubId = club.id
                WHERE teamStaff.personId = ?

                    `
        const staffTeams = await connection.query(staffTeamsQuery, [req.params.id]);

        personConnectedWithATeams.staffTeams = staffTeams;

        // Get the persons stats from PlayerGame and sum them up
        // plus count the number of games played
        // const statsQuery = `
        //         SELECT SUM(goals) as goals, SUM(assist) as assists, SUM(yellowCard) as yellowCards, SUM(redCard) as redCards FROM PlayerGame
        //         WHERE PlayerGame.PersonId = ?
        //                     `

        const statsQuery = `
        SELECT playerGame.personId, SUM(goals) as goals, SUM(assist) as assists, SUM(yellowCard) as yellowCards, SUM(redCard) as redCards FROM playerGame
        WHERE playerGame.personId = ?
                    `

        const stats = await connection.query(statsQuery, [req.params.id]);
        personConnectedWithATeams.stats = stats[0];

        console.log(personConnectedWithATeams.stats)

        connection.release();
        res.send(personConnectedWithATeams);
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

router.get("/", async (req, res) => {
    let allPersonsData = {};
    console.log("Get all persons");
    try {
        const connection = await pool.getConnection();
        const query = "SELECT * FROM person";
        const persons = await connection.query(query);
        allPersonsData = persons;
        connection.release();
        res.send(allPersonsData);
    } catch (err) {
        res.status(500);
        res.send({
            errorCode: "server_error",
            errorMessage: "Failed to fetch persons from the server."
        });
    }

});

export default router;