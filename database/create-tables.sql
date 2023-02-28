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
