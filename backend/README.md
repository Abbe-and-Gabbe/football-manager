# Backend

## Setup

The backend is using express.js, and can be run with `npm start`, or with `docker compose up` from the projects root directory.


## Routes

### GET /person/:id

Returns a person with the given id.

If the person exists, the response will be a 200 with the person in the body. If the person does not exist, the response will be a 404. Else it fails, the response will be a 500.