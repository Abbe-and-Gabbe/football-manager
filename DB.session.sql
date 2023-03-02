SELECT Person.id, Person.firstName, Person.lastName, Person.email, Person.gender, Person.phoneNumber, Person.password
FROM TeamPlayer
JOIN Team ON TeamPlayer.TeamId = Team.id
JOIN Person ON TeamPlayer.PersonId = Person.id
WHERE Team.id = 1;
