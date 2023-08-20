
import { Router } from "express";
import { pool } from "../db.js";
import { verySecretToken } from "./auth.js";

const router = Router();

router.get("/:id", async (req, res) => {
  let id = req.params.id;
  let newsArticleData = {};
  try {
    const connection = await pool.getConnection();
    const query = `
        SELECT news.title, news.content, news.published, person.firstName, person.lastName
        FROM news 
        JOIN person ON news.personId = person.id
        WHERE news.id = ?
        `;
    const news = await connection.query(query, [id]);
    connection.release();

    if (news.length === 0) {
      return res.status(404).json({
        errorCode: "not_found",
        errorMessage: "News article not found",
      });
    }

    newsArticleData = news[0];
    res.json(newsArticleData);
  } catch (err) {
    console.error(err);
    res.status(500).json({
      errorCode: "server_error",
      errorMessage: "Something went wrong on the server side",
    });
  }
});



router.post("/", async (req, res) => {
  const authorizationHeaderValue = req.get("Authorization")
  const accessToken = authorizationHeaderValue.substring(7)

  let isValidJTW = verySecretToken(accessToken)

  if (!isValidJTW) {
    res.status(401).json({ error: "unauthorized" })
    return
  }
  const maxTitleLength = 20;
  const maxContentLength = 100;

  const { personId, teamId, title, content } = req.body;

  if (title.length > maxTitleLength || title.trim() === "") {
    res.status(400).json({
      error: "Invalid title",
      errorMessage: `Title must not exceed ${maxTitleLength} characters and must not be empty`,
    });
  } else if (content.length > maxContentLength || content.trim() === "") {
    res.status(400).json({
      error: "Invalid content",
      errorMessage: `Content must not exceed ${maxContentLength} characters and must not be empty`,
    });
  } else {
    try {
      const connection = await pool.getConnection();
      const published = new Date(); // Correctly placed here
      const query = `
        INSERT INTO news (personId, teamId, title, content, published)
        VALUES (?, ?, ?, ?, ?)
      `;
      const result = await connection.query(query, [
        personId,
        teamId,
        title,
        content,
        published,
      ]);
      const newsId = result.insertId;
      connection.release();
      res.status(201).json({
        id: newsId,
        message: "News article created successfully",
      });
    } catch (err) {
      console.error(err);
      res.status(500).json({
        errorCode: "server_error",
        errorMessage: "Failed to create news article",
      });
    }
  }
});



router.put("/:id", async (req, res) => {
  const id = req.params.id;
  const newsData = req.body;
  console.log(`Edit news article ${id} for person with id: ${newsData.personId}`);

  const maxUpdateTitleLength = 20;
  const maxUpdateContentLength = 100;

  if (newsData.title.length > maxUpdateTitleLength || newsData.title.trim() === "") {
    res.status(400).json({
      error: "Invalid title",
      errorMessage: `Title must not exceed ${maxUpdateTitleLength} characters and must not be empty`,
    });
  } else if (newsData.content.length > maxUpdateContentLength || newsData.content.trim() === "") {
    res.status(400).json({
      error: "Invalid content",
      errorMessage: `Content must not exceed ${maxUpdateContentLength} characters and must not be empty`,
    });
  } else {
    try {
      const connection = await pool.getConnection();
      const query = `
        UPDATE news
        SET teamId = ?, title = ?, content = ?
        WHERE id = ?
      `;
      const result = await connection.query(query, [
        newsData.teamId,
        newsData.title,
        newsData.content,
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
  }
});


router.delete("/:id", async (req, res) => {
  let id = req.params.id;
  try {
    const connection = await pool.getConnection();
    const query = "DELETE FROM news WHERE id = ?";
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
