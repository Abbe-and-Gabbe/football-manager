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
  let newsData = req.body;
  try {
    const connection = await pool.getConnection();
    const query = `
      INSERT INTO news (personId, teamId, title, content, published)
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
                UPDATE news
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

//delete news article
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
