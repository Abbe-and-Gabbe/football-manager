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
        const query = "INSERT INTO person (firstName, lastName, email, password) VALUES (?, ?, ?, ?)"

        // Decrypt password
        let password = req.query.password;

        // Hash the password
        let hasedPassword = await bcrypt.hash(password, 10);

        connection.query(query, [req.query.firstName, req.query.lastName, req.query.email, hasedPassword]);
        connection.release();

        // Return the new user id from the database
        const newConnection = await pool.getConnection();
        const newQuery = "SELECT id, firstName, lastName FROM person WHERE email = ?"
        const result = await newConnection.query(newQuery, [req.query.email]);
        newConnection.release();

        res.send(result[0]);
    }
})

router.get("/login", async (req, res) => {
    const { email, password } = req.query;
    console.log("Login attempt: " + email + " " + password)

    // Hash the password

    const connection = await pool.getConnection();
    const query = "SELECT id, firstName, lastName, password FROM person WHERE email = ?"

    const result = await connection.query(query, [email]);

    if (result.length > 0) {
        console.log(result[0])
        // Check if password is correct

        let passwordCorrect = await bcrypt.compare(password, result[0].password);

        if (passwordCorrect) {
            // Check if the user has connection in TeamStaff

            const teamStaffConnection = await pool.getConnection();

            const teamStaffQuery = "SELECT * FROM teamStaff WHERE personId = ?"

            const teamStaffResult = await teamStaffConnection.query(teamStaffQuery, [result[0].id]);

            if (teamStaffResult.length > 0) {
                result[0].isStaff = true;
            } else {
                result[0].isStaff = false;
            }

            // Generate token

            result[0].JWT = Jwt.sign({ id: result[0].id }, SECRET_TOKEN, {
                expiresIn: 24 * 60 * 60 // 24 hours
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

export function verySecretToken(token) {
    console.log("Getting token" + token);
    try {
        const decoded = Jwt.verify(token, SECRET_TOKEN, (error, payload) => {
            console.log("Decoded: " + payload);
            if (error) {
                return false;
            }
            console.log("Returning true");
            return true;
        })
        return decoded;
    }
    catch (error) {
        console.log(error);
        return false;
    }
}

async function checkIfUserHasAccount(email) {
    // Check if email already exists
    const connection = await pool.getConnection();
    const query = "SELECT * FROM person WHERE email = ?"

    const result = await connection.query(query, [email]);

    if (result.length > 0) {
        return true;
    }
    return false;
}

export default router;