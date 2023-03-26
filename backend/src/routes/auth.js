import { Router } from "express";
import { pool } from "../db.js"
import Jwt from "jsonwebtoken";
import bcrypt from "bcrypt";

const router = Router();

const SECRET_TOKEN = "verySecretToken"

router.post("/signup", async (req, res) => {
    // Check if email already exists

    if (await checkIfUserHasAccount(req.query.email)) {
        res.status(409);
        res.send({
            errorCode: "conflict",
            errorMessage: "Email already exists"
        })
        return;
    } else {
        // Create new user
        const connection = await pool.getConnection();
        const query = "INSERT INTO Person (firstName, lastName, email, password, firebaseId) VALUES (?, ?, ?, ?, ?)"

        // Decrypt password
        let password = req.query.password;

        // Hash the password
        password = await bcrypt.hash(password, 10);

        console.log(password)

        connection.query(query, [req.query.firstName, req.query.lastName, req.query.email, password, req.query.firebaseId]);
        connection.release();

        // Return the new user id from the database
        const newConnection = await pool.getConnection();
        const newQuery = "SELECT id, firstName, lastName, firebaseId FROM Person WHERE email = ?"
        const result = await newConnection.query(newQuery, [req.query.email]);
        newConnection.release();

        // Check if the user has connection in TeamStaff

        const teamStaffConnection = await pool.getConnection();

        const teamStaffQuery = "SELECT * FROM TeamStaff WHERE personId = ?"

        const teamStaffResult = await teamStaffConnection.query(teamStaffQuery, [result[0].id]);

        if (teamStaffResult.length > 0) {
            result[0].isStaff = true;
        } else {
            result[0].isStaff = false;
        }

        res.send(result[0]);
    }
})

router.get("/login", async (req, res) => {
    const { email, password } = req.query;
    console.log("Login attempt: " + email + " " + password)

    // Hash the password

    const connection = await pool.getConnection();
    const query = "SELECT id, firstName, lastName, firebaseId, password FROM Person WHERE email = ?"

    const result = await connection.query(query, [email]);

    if (result.length > 0) {
        console.log(result[0])
        // Check if password is correct

        let passwordCorrect

        passwordCorrect = await bcrypt.compare(password, result[0].password);

        if (passwordCorrect) {
            // Check if the user has connection in TeamStaff

            const teamStaffConnection = await pool.getConnection();

            const teamStaffQuery = "SELECT * FROM TeamStaff WHERE personId = ?"

            const teamStaffResult = await teamStaffConnection.query(teamStaffQuery, [result[0].id]);

            if (teamStaffResult.length > 0) {
                result[0].isStaff = true;
            } else {
                result[0].isStaff = false;
            }

            // Generate token

            result[0].JWT = Jwt.sign({ id: result[0].id }, SECRET_TOKEN, {
                expiresIn: 86400 // 24 hours
            });

            result[0].loggedIn = true;

            console.log(result[0])

            res.send(result[0]);
            teamStaffConnection.release();
            connection.release();
        } else {
            res.send({
                errorCode: "wrong_password",
                errorMessage: "Wrong password"
            })
            connection.release();
        }
    } else {
        res.send({
            errorCode: "not_found",
            errorMessage: "User not found"
        })
    }

    connection.release();
})


async function checkIfUserHasAccount(email) {
    // Check if email already exists
    const connection = await pool.getConnection();
    const query = "SELECT * FROM Person WHERE email = ?"

    const result = await connection.query(query, [email]);

    if (result.length > 0) {
        // Conflict
        return true;
    }
    return false;
}

export default router;