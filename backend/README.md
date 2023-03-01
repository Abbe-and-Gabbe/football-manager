# Backend

## Setup

The backend is using express.js, and can be run with `npm start`, or with `docker compose up` from the projects root directory.


## Routes

### GET /person/:id

Returns a person with the given id.

If the person exists, the response will be a 200 with the person in the body. If the person does not exist, the response will be a 404. Else it fails, the response will be a 500.

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