CREATE TABLE Person (
  id int PRIMARY KEY,
  firstName varchar(255),
  lastName varchar(255),
  email varchar(255),
  gender varchar(255),
  phoneNumber varchar(255),
  password varchar(255)
);

CREATE TABLE Club (
  id int PRIMARY KEY,
  name varchar(255)
);

CREATE TABLE Team (
  id int PRIMARY KEY,
  clubId int,
  teamName varchar(255)
);

CREATE TABLE TeamStaff (
  PersonId int,
  TeamId int,
  role varchar(255)
);

CREATE TABLE TeamPlayer (
  PersonId int,
  TeamId int
);

CREATE TABLE Training (
  id int PRIMARY KEY,
  TeamId int,
  date datetime
);

CREATE TABLE PlayerTraining (
  PersonId int,
  TrainingId int
);

CREATE TABLE Game (
  id int PRIMARY KEY,
  LeagueId int,
  homeTeam int,
  awayTeam int,
  homeScore int,
  awayScore int,
  date datetime
);

CREATE TABLE League (
  id int PRIMARY KEY,
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

ALTER TABLE Team ADD FOREIGN KEY (clubId) REFERENCES Club (id);

ALTER TABLE TeamStaff ADD FOREIGN KEY (PersonId) REFERENCES Person (id);

ALTER TABLE TeamStaff ADD FOREIGN KEY (TeamId) REFERENCES Team (id);

ALTER TABLE TeamPlayer ADD FOREIGN KEY (PersonId) REFERENCES Person (id);

ALTER TABLE TeamPlayer ADD FOREIGN KEY (TeamId) REFERENCES Team (id);

ALTER TABLE Training ADD FOREIGN KEY (TeamId) REFERENCES Team (id);

ALTER TABLE PlayerTraining ADD FOREIGN KEY (PersonId) REFERENCES Person (id);

ALTER TABLE PlayerTraining ADD FOREIGN KEY (TrainingId) REFERENCES Training (id);

ALTER TABLE Game ADD FOREIGN KEY (LeagueId) REFERENCES League (id);

ALTER TABLE Game ADD FOREIGN KEY (homeTeam) REFERENCES Team (id);

ALTER TABLE Game ADD FOREIGN KEY (awayTeam) REFERENCES Team (id);

ALTER TABLE PlayerGame ADD FOREIGN KEY (PersonId) REFERENCES Person (id);

ALTER TABLE PlayerGame ADD FOREIGN KEY (GameId) REFERENCES Game (id);

ALTER TABLE News ADD FOREIGN KEY (PersonId) REFERENCES Person (id);

ALTER TABLE News ADD FOREIGN KEY (TeamId) REFERENCES Team (id);

ALTER TABLE GameSummary ADD FOREIGN KEY (GameId) REFERENCES Game (id);

ALTER TABLE GameSummary ADD FOREIGN KEY (PersonId) REFERENCES Person (id);

-- Insert test data into Person table
INSERT INTO Person (id, firstName, lastName, email, gender, phoneNumber, password)
VALUES (1, 'John', 'Doe', 'johndoe@example.com', 'Male', '555-1234', 'password'),
       (2, 'Jane', 'Doe', 'janedoe@example.com', 'Female', '555-5678', 'password'),
       (3, 'Bob', 'Smith', 'bobsmith@example.com', 'Male', '555-2468', 'password'),
       (4, 'Samantha', 'Johnson', 'samanthajohnson@example.com', 'Female', '555-3690', 'password'),
       (5, 'James', 'Williams', 'jameswilliams@example.com', 'Male', '555-1357', 'password');

-- Insert test data into Club table
INSERT INTO Club (id, name)
VALUES (1, 'Manchester United'),
       (2, 'Chelsea'),
       (3, 'Arsenal');

-- Insert test data into Team table
INSERT INTO Team (id, clubId, teamName)
VALUES (1, 1, 'Manchester United A'),
       (2, 1, 'Manchester United B'),
       (3, 2, 'Chelsea A'),
       (4, 2, 'Chelsea B'),
       (5, 3, 'Arsenal A');

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
INSERT INTO Training (id, TeamId, date)
VALUES (1, 1, '2023-03-01 10:00:00'),
       (2, 1, '2023-03-03 10:00:00'),
       (3, 2, '2023-03-02 10:00:00'),
       (4, 2, '2023-03-04 10:00:00'),
       (5, 3, '2023-03-01 14:00:00'),
       (6, 3, '2023-03-03 14:00:00'),
       (7, 4, '2023-03-02 14:00:00'),
       (8, 4, '2023-03-04 14:00:00'),
       (9, 5, '2023-03-01 16:00:00'),
       (10, 5, '2023-03-03 16:00:00');
