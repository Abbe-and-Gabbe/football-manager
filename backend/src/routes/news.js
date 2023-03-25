import { Router } from "express";
import { pool } from "../db.js";

const router = Router();

router.get("/:id", async (req, res) => {
  let id = req.params.id;
  let data = {};
  try {
    const connection = await pool.getConnection();
    const query = `
        SELECT News.title, News.content, News.published, Person.firstName, Person.lastName
        FROM News 
        JOIN Person ON News.PersonId = Person.id
        WHERE News.id = ?

        `;
    const news = await connection.query(query, [id]);
    data = news[0];
    connection.release();
    res.send(data);
  } catch (err) {
    console.error(err);
    res.status(404);
    res.send({
      errorCode: "not_found",
      errorMessage: "News article not found",
    });
  }
});

router.post("/", async (req, res) => {
  let newsData = req.body;
  try {
    const connection = await pool.getConnection();
    const query = `
          INSERT INTO News (personId, teamId, title, content, published)
          VALUES (?, ?, ?, ?, ?)
        `;
    const result = await connection.query(query, [
      newsData.personId,
      newsData.teamId,
      newsData.title,
      newsData.content,
      newsData.published,
    ]);
    const newsId = result.insertId;
    connection.release();
    res.send({
      id: newsId,
      message: "News article created successfully",
    });
  } catch (err) {
    console.error(err);
    res.status(500);
    res.send({
      errorCode: "internal_server_error",
      errorMessage: "Failed to create news article",
    });
  }
});

router.put("/:id", async (req, res) => {
  let id = req.params.id;
  let newsData = req.body;
  console.log(
    `Edit news article ${id} for person with id: ${newsData.personId}`
  );
  try {
    const connection = await pool.getConnection();
    const query = `
                UPDATE News
                SET teamId = ?, title = ?, content = ?, published = ?
                WHERE id = ?
              `;
    const result = await connection.query(query, [
      newsData.teamId,
      newsData.title,
      newsData.content,
      newsData.published,
      id,
    ]);
    connection.release();
    if (result.affectedRows === 0) {
      res.status(404);
      res.send({
        errorCode: "not_found",
        errorMessage: "News article not found",
      });
    } else {
      // Check if the updated news article belongs to the user who made the request
      const updatedNewsArticle = await getNewsArticleById(id);
      if (updatedNewsArticle.personId !== newsData.personId) {
        res.status(403);
        res.send({
          errorCode: "forbidden",
          errorMessage: "You are not authorized to update this news article",
        });
      } else {
        res.send({
          message: "News article updated successfully",
        });
      }
    }
  } catch (err) {
    console.error(err);
    res.status(500);
    res.send({
      errorCode: "internal_server_error",
      errorMessage: "Failed to update news article",
    });
  }
});

router.delete("/:id", async (req, res) => {
  let id = req.params.id;
  try {
    const connection = await pool.getConnection();
    const query = "DELETE FROM News WHERE id = ?";
    const result = await connection.query(query, [id]);

    connection.release();
    if (result.affectedRows === 0) {
      res.status(404);
      res.send({
        errorCode: "not_found",
        errorMessage: "News article not found",
      });
    } else {
      res.send({
        message: "News article deleted successfully",
      });
    }
  } catch (err) {
    console.error(err);
    res.status(500);
    res.send({
      errorCode: "internal_server_error",
      errorMessage: "Failed to delete news article",
    });
  }
});

export default router;
