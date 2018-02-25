#! /bin/bash

docker stop debianeo; docker rm debianeo
docker build -t "debianeo" .
docker run -t -i -p 8040:80 -d --name debianeo debianeo
docker exec -i -t debianeo /bin/sh



