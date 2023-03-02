import { createPool } from "mariadb";

const pool = createPool({
    host: "db",
    port: 3306,
    user: "root",
    password: "abc123",
    database: "Football-ManagerDB",
});

// pool on error
pool.on("error", function (err) {
    console.log("MariaDB connection error: " + err);
});

export { pool };