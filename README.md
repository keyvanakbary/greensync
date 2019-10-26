# Greensync

Tool for syncing [Greenhouse Harvest API](https://developers.greenhouse.io/harvest.html) and a MySQL database of your choice. It pulls data every 15 minutes.

## Run

Build and run the image

    docker build -t greensync
    docker run
      -e DB_NAME="greensync"
      -e DB_USER="greensync"
      -e DB_PASS="pass"
      -e DB_HOST="localhost"
      -e GREENHOUSE_API_TOKEN="YOUR_TOKEN"
      greensync

Run the tool along with a MySQL database via docker-compose

    GREENHOUSE_API_TOKEN="YOUR_TOKEN_HERE" docker-compose up

---

Run just the database

    docker-compose up mysql

Run the service with mix

    mix run

Run the mix syncing task

    mix sync