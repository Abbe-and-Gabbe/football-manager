SELECT * FROM TeamPlayer
JOIN Club ON Club.id = TeamPlayer.TeamId
WHERE PersonId = 1