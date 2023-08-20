CREATE TABLE person (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  firstName VARCHAR(50),
  lastName VARCHAR(50),
  email VARCHAR(254),
  gender VARCHAR(10),
  phoneNumber VARCHAR(15),
  password VARCHAR(255)
);
CREATE TABLE club (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  clubName VARCHAR(255)
);
CREATE TABLE team (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  clubId INT,
  teamName VARCHAR(255),
  FOREIGN KEY (clubId) REFERENCES club (id)
);
CREATE TABLE training (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  teamId INT,
  startDate DATETIME,
  stopDate DATETIME,
  FOREIGN KEY (teamId) REFERENCES team (id)
);
CREATE TABLE teamStaff (
  personId INT,
  teamId INT,
  role VARCHAR(255),
  FOREIGN KEY (personId) REFERENCES person (id),
  FOREIGN KEY (teamId) REFERENCES team (id)
);
CREATE TABLE teamPlayer (
  personId INT,
  teamId INT,
  FOREIGN KEY (personId) REFERENCES person (id),
  FOREIGN KEY (teamId) REFERENCES team (id)
);
CREATE TABLE playerTraining (
  personId INT,
  trainingId INT,
  FOREIGN KEY (personId) REFERENCES person (id),
  FOREIGN KEY (trainingId) REFERENCES training (id)
);
CREATE TABLE league (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  leagueName VARCHAR(255),
  federation VARCHAR(255)
);
CREATE TABLE game (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  leagueId INT,
  homeTeamId INT,
  awayTeamId INT,
  homeScoreId INT,
  awayScoreId INT,
  date DATETIME,
  FOREIGN KEY (leagueId) REFERENCES league (id),
  FOREIGN KEY (homeTeamId) REFERENCES team (id),
  FOREIGN KEY (awayTeamId) REFERENCES team (id)
);
CREATE TABLE playerGame (
  personId INT,
  gameId INT,
  goals INT,
  assist INT,
  yellowCard INT,
  redCard INT,
  FOREIGN KEY (personId) REFERENCES person (id),
  FOREIGN KEY (gameId) REFERENCES game (id)
);
CREATE TABLE news (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  personId INT,
  teamId INT,
  title VARCHAR(255),
  content VARCHAR(255),
  published DATETIME,
  FOREIGN KEY (personId) REFERENCES person (id),
  FOREIGN KEY (teamId) REFERENCES team (id)
);
CREATE TABLE gameSummary (
  gameId INT,
  personId INT,
  content VARCHAR(255),
  FOREIGN KEY (gameId) REFERENCES game (id),
  FOREIGN KEY (personId) REFERENCES person (id)
);
-- Insert test data into Person table
INSERT INTO person (
    firstName,
    lastName,
    email,
    gender,
    phoneNumber,
    password
  )
VALUES (
    'John',
    'Doe',
    'johndoe@example.com',
    'Male',
    '555-1234',
    'password'
  ),
  (
    'Jane',
    'Doe',
    'janedoe@example.com',
    'Female',
    '555-5678',
    'password'
  ),
  (
    'Bob',
    'Smith',
    'bobsmith@example.com',
    'Male',
    '555-2468',
    'password'
  ),
  (
    'Samantha',
    'Johnson',
    'samanthajohnson@example.com',
    'Female',
    '555-3690',
    'password'
  ),
  (
    'James',
    'Williams',
    'jameswilliams@example.com',
    'Male',
    '555-1357',
    'password'
  );
-- Insert test data into club table
INSERT INTO club (clubName)
VALUES ('Manchester United'),
  ('Chelsea'),
  ('Arsenal');
-- Insert test data into team table
INSERT INTO team (clubId, teamName)
VALUES (1, 'Manchester United A'),
  (1, 'Manchester United B'),
  (2, 'Chelsea A'),
  (2, 'Chelsea B'),
  (3, 'Arsenal A');
-- Insert test data into teamStaff table
INSERT INTO teamStaff (personId, teamId, role)
VALUES (1, 1, 'Head Coach'),
  (2, 1, 'Assistant Coach'),
  (3, 2, 'Head Coach'),
  (4, 2, 'Assistant Coach'),
  (5, 3, 'Head Coach'),
  (1, 3, 'Physiotherapist'),
  (2, 3, 'Fitness Coach'),
  (3, 4, 'Physiotherapist'),
  (4, 4, 'Fitness Coach'),
  (5, 5, 'Head Coach');
-- Insert test data into teamPlayer table
INSERT INTO teamPlayer (personId, teamId)
VALUES (1, 1),
  (2, 1),
  (3, 1),
  (4, 2),
  (5, 3),
  (1, 3),
  (2, 3),
  (3, 3),
  (4, 4),
  (5, 5);
-- Insert test data into training table
INSERT INTO training (teamId, startDate, stopDate)
VALUES (1, '2023-03-01 10:00:00', '2023-03-01 12:00:00'),
  (2, '2023-03-01 10:00:00', '2023-03-01 12:00:00'),
  (3, '2023-03-01 10:00:00', '2023-03-01 12:00:00'),
  (4, '2023-03-01 10:00:00', '2023-03-01 12:00:00'),
  (5, '2023-03-01 10:00:00', '2023-03-01 12:00:00');
-- Insert test data into playerTraining table
INSERT INTO playerTraining (personId, TrainingId)
VALUES (1, 1),
  (2, 1),
  (3, 1),
  (4, 2),
  (5, 3),
  (1, 3),
  (2, 3),
  (3, 3),
  (4, 4),
  (5, 5);
-- Insert test data into league table
INSERT INTO league (leagueName, federation)
VALUES ('Premier League', 'FA'),
  ('Championship', 'FA'),
  ('League One', 'FA'),
  ('League Two', 'FA'),
  ('National League', 'FA');
-- Insert test data into game table
INSERT INTO game (
    leagueId,
    homeTeamId,
    awayTeamId,
    homeScoreId,
    awayScoreId,
    date
  )
VALUES (1, 1, 2, 2, 1, '2023-03-01 10:00:00'),
  (1, 1, 2, 2, 1, '2023-03-03 10:00:00'),
  (1, 2, 1, 1, 2, '2023-03-02 10:00:00'),
  (1, 2, 1, 1, 2, '2023-03-04 10:00:00'),
  (1, 3, 4, 2, 1, '2023-03-01 14:00:00'),
  (1, 3, 4, 2, 1, '2023-03-03 14:00:00'),
  (1, 4, 3, 1, 2, '2023-03-02 14:00:00'),
  (1, 4, 3, 1, 2, '2023-03-04 14:00:00'),
  (1, 5, 1, 2, 1, '2023-03-01 16:00:00'),
  (1, 5, 1, 2, 1, '2023-03-03 16:00:00');
-- Insert test data into playerGame table
INSERT INTO playerGame (
    personId,
    gameId,
    goals,
    assist,
    yellowCard,
    redCard
  )
VALUES (1, 1, 1, 0, 0, 0),
  (2, 1, 0, 1, 0, 0),
  (3, 1, 1, 0, 0, 0),
  (4, 2, 0, 0, 1, 0),
  (5, 3, 0, 0, 0, 1),
  (1, 3, 0, 0, 0, 1),
  (2, 3, 0, 0, 0, 1),
  (3, 3, 0, 0, 0, 1),
  (4, 4, 0, 0, 0, 1),
  (5, 5, 0, 0, 0, 1),
  (1, 5, 0, 0, 0, 1),
  (2, 5, 0, 0, 0, 1),
  (3, 5, 0, 0, 0, 1),
  (4, 6, 0, 0, 0, 1),
  (5, 7, 0, 0, 0, 1),
  (1, 7, 0, 0, 0, 1),
  (2, 7, 0, 0, 0, 1),
  (3, 7, 0, 0, 0, 1),
  (4, 8, 0, 0, 0, 1),
  (5, 9, 0, 0, 0, 1),
  (1, 9, 0, 0, 0, 1),
  (2, 9, 0, 0, 0, 1),
  (3, 9, 0, 0, 0, 1),
  (4, 10, 0, 0, 0, 1),
  (5, 10, 0, 0, 0, 1);
-- Insert test data into gameSummary table
INSERT INTO gameSummary (gameId, personId, content)
VALUES (1, 1, 'Game 1 summary'),
  (2, 1, 'Game 2 summary'),
  (3, 1, 'Game 3 summary'),
  (4, 1, 'Game 4 summary'),
  (5, 1, 'Game 5 summary'),
  (6, 1, 'Game 6 summary'),
  (7, 1, 'Game 7 summary'),
  (8, 1, 'Game 8 summary'),
  (9, 1, 'Game 9 summary'),
  (10, 1, 'Game 10 summary');
-- Insert test data into news table
INSERT INTO news (personId, teamId, title, content, published)
VALUES (
    1,
    1,
    'News 1',
    'News 1 content',
    '2023-03-01 10:00:00'
  ),
  (
    2,
    1,
    'News 2',
    'News 2 content',
    '2023-03-03 10:00:00'
  ),
  (
    3,
    2,
    'News 3',
    'News 3 content',
    '2023-03-02 10:00:00'
  ),
  (
    4,
    2,
    'News 4',
    'News 4 content',
    '2023-03-04 10:00:00'
  ),
  (
    5,
    3,
    'News 5',
    'News 5 content',
    '2023-03-01 14:00:00'
  ),
  (
    1,
    3,
    'News 6',
    'News 6 content',
    '2023-03-03 14:00:00'
  ),
  (
    2,
    4,
    'News 7',
    'News 7 content',
    '2023-03-02 14:00:00'
  ),
  (
    3,
    4,
    'News 8',
    'News 8 content',
    '2023-03-04 14:00:00'
  ),
  (
    4,
    5,
    'News 9',
    'News 9 content',
    '2023-03-01 16:00:00'
  ),
  (
    5,
    5,
    'News 10',
    'News 10 content',
    '2023-03-03 16:00:00'
  );