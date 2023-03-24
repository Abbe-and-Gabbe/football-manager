import { Router } from "express";
import { pool } from "../db.js"

const router = Router();

router.post("/signup", async (req, res) => {
    console.log("Sign up new user")
    console.log(req.body)

    const { email, password, firstName, lastName, phoneNumber } = req.body;

    // Check if email already exists
    if (await checkIfUserHasAccount(email)) {
        return;
    }
})

async function checkIfUserHasAccount(email) {
    // Check if email already exists
    const connection = await pool.getConnection();
    const query = "SELECT * FROM Person WHERE email = ?"

    const result = await connection.query(query, [email]);

    if (result.length > 0) {
        // Conflict
        res.status(409);
        res.send({
            errorCode: "email_already_exists",
            errorMessage: "Email already exists"
        })
        return true;
    }
    return false;
}

export default router;