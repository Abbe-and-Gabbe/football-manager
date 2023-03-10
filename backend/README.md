# Backend

## Setup

The backend is using express.js, and can be run with `npm start`, or with `docker compose up` from the projects root directory.


## Routes

### GET /person/:id

Returns a person with the given id.

- Success: 200
- Not found: 404
- Error: 500

The data will be retuned in the following format:

```json
{
    "id": 1,
    "firstName": "John",
    "lastName": "Doe",
    "email": "johndoe@example.com",
    "gender": "Male",
    "phoneNumber": "555-1234",
    "password": "*********",
    "playerTeams": [
        {
            "id": 1,
            "teamName": "Manchester United A",
            "clubId": 1
        },
        {
            "id": 3,
            "teamName": "Chelsea A",
            "clubId": 2
        }
    ],
    "staffTeams": [
        {
            "id": 1,
            "teamName": "Manchester United A",
            "clubId": 1,
            "role": "Head Coach"
        },
        {
            "id": 3,
            "teamName": "Chelsea A",
            "clubId": 2,
            "role": "Physiotherapist"
        }
    ]
}
```

If the person is not found, the following will be returned:

```json
{
    "errorCode": "not_found",
    "message": "Person not found"
}
```

### GET /team/:id

Returns a team with the given id, including all players and staff.

- Success: 200
- Not found: 404
- Error: 500

The response will look like this:

```json
{
    "id": 1,
    "teamName": "Manchester United A",
    "clubName": "Manchester United",
    "clubId": 1,
    "players": [
        {
            "id": 1,
            "firstName": "John",
            "lastName": "Doe",
            "email": "mail@mail.com"
        },
        {...}
    ],
    "staff": [
        {
            "id": 1,
            "firstName": "John",
            "lastName": "Doe",
            "email": "",
            "role": "Head Coach"
        }, 
        {...}
    ]
}
```
