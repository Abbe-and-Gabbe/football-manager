import { Router } from "express";
import { pool } from "../db.js"

const router = Router();

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

export default router;