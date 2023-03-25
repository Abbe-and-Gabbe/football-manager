import { Router } from "express";
import { pool } from "../db.js";

const router = Router();

router.get("news/:id", async (req, res) => {
    let id = req.params.id;
    let newsId = req.params.newsId;
    let data = {};
    try {
      const connection = await pool.getConnection();
      const query = `
        SELECT * FROM News
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
        errorMessage: "News article not found",
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
      const result = await connection.query(query, [
        id,
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
      const result = await connection.query(query, [
        newsData.teamId,
        newsData.title,
        newsData.content,
        newsData.published,
        newsId,
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
        res.send({
          message: "News article updated successfully",
        });
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
  
  router.delete("news/:id", async (req, res) => {
    let id = req.params.id;
    let newsId = req.params.newsId;
    try {
      const connection = await pool.getConnection();
      const query = "DELETE FROM News WHERE id = ? AND personId = ?";
      const result = await connection.query(query, [newsId, id]);
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