
CREATE TABLE Person (
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  firstName varchar(255),
  lastName varchar(255),
  email varchar(255),
  gender varchar(255),
  phoneNumber varchar(255),
  firebaseId varchar(255),
  password varchar(255)
);
CREATE TABLE Club (
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  clubName varchar(255)
);
CREATE TABLE Team (
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  clubId int,
  teamName varchar(255)
);
CREATE TABLE Training (
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  TeamId int,
  startDate datetime,
  stopDate datetime
);
CREATE TABLE TeamStaff (
  PersonId int,
  TeamId int,
  role varchar(255)
);
CREATE TABLE TeamPlayer (PersonId int, TeamId int);
CREATE TABLE PlayerTraining (PersonId int, TrainingId int);
CREATE TABLE Game (
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  LeagueId int,
  homeTeam int,
  awayTeam int,
  homeScore int,
  awayScore int,
  date datetime
);
CREATE TABLE League (
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  leagueName varchar(255),
  federation varchar(255)
);
CREATE TABLE PlayerGame (
  PersonId int,
  GameId int,
  goals int,
  assist int,
  yellowCard int,
  redCard int
);
CREATE TABLE News (
  id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  PersonId int,
  TeamId int,
  title varchar(255),
  content varchar(255),
  published datetime
);
CREATE TABLE GameSummary (
  GameId int,
  PersonId int,
  content varchar(255)
);
ALTER TABLE Team
ADD FOREIGN KEY (clubId) REFERENCES Club (id);
ALTER TABLE TeamStaff
ADD FOREIGN KEY (PersonId) REFERENCES Person (id);
ALTER TABLE TeamStaff
ADD FOREIGN KEY (TeamId) REFERENCES Team (id);
ALTER TABLE TeamPlayer
ADD FOREIGN KEY (PersonId) REFERENCES Person (id);
ALTER TABLE TeamPlayer
ADD FOREIGN KEY (TeamId) REFERENCES Team (id);
ALTER TABLE Training
ADD FOREIGN KEY (TeamId) REFERENCES Team (id);
ALTER TABLE PlayerTraining
ADD FOREIGN KEY (PersonId) REFERENCES Person (id);
ALTER TABLE PlayerTraining
ADD FOREIGN KEY (TrainingId) REFERENCES Training (id);
ALTER TABLE Game
ADD FOREIGN KEY (LeagueId) REFERENCES League (id);
ALTER TABLE Game
ADD FOREIGN KEY (homeTeam) REFERENCES Team (id);
ALTER TABLE Game
ADD FOREIGN KEY (awayTeam) REFERENCES Team (id);
ALTER TABLE PlayerGame
ADD FOREIGN KEY (PersonId) REFERENCES Person (id);
ALTER TABLE PlayerGame
ADD FOREIGN KEY (GameId) REFERENCES Game (id);
ALTER TABLE News
ADD FOREIGN KEY (PersonId) REFERENCES Person (id);
ALTER TABLE News
ADD FOREIGN KEY (TeamId) REFERENCES Team (id);
ALTER TABLE GameSummary
ADD FOREIGN KEY (GameId) REFERENCES Game (id);
ALTER TABLE GameSummary
ADD FOREIGN KEY (PersonId) REFERENCES Person (id);
-- Insert test data into Person table
INSERT INTO Person (
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
-- Insert test data into Club table
INSERT INTO Club (clubName)
VALUES ('Manchester United'),
  ('Chelsea'),
  ('Arsenal');
-- Insert test data into Team table
INSERT INTO Team (clubId, teamName)
VALUES (1, 'Manchester United A'),
  (1, 'Manchester United B'),
  (2, 'Chelsea A'),
  (2, 'Chelsea B'),
  (3, 'Arsenal A');
-- Insert test data into TeamStaff table
INSERT INTO TeamStaff (PersonId, TeamId, role)
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
-- Insert test data into TeamPlayer table
INSERT INTO TeamPlayer (PersonId, TeamId)
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
-- Insert test data into Training table
INSERT INTO Training (TeamId, startDate, stopDate)
VALUES (1, '2023-03-01 10:00:00', '2023-03-01 12:00:00'),
  (2, '2023-03-01 10:00:00', '2023-03-01 12:00:00'),
  (3, '2023-03-01 10:00:00', '2023-03-01 12:00:00'),
  (4, '2023-03-01 10:00:00', '2023-03-01 12:00:00'),
  (5, '2023-03-01 10:00:00', '2023-03-01 12:00:00');
-- Insert test data into PlayerTraining table
INSERT INTO PlayerTraining (PersonId, TrainingId)
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
-- Insert test data into League table
INSERT INTO League (leagueName, federation)
VALUES ('Premier League', 'FA'),
  ('Championship', 'FA'),
  ('League One', 'FA'),
  ('League Two', 'FA'),
  ('National League', 'FA');
-- Insert test data into Game table
INSERT INTO Game (
    LeagueId,
    homeTeam,
    awayTeam,
    homeScore,
    awayScore,
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
-- Insert test data into PlayerGame table
INSERT INTO PlayerGame (
    PersonId,
    GameId,
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
-- Insert test data into GameSummary table
INSERT INTO GameSummary (GameId, PersonId, content)
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
-- Insert test data into News table
INSERT INTO News (PersonId, TeamId, title, content, published)
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
