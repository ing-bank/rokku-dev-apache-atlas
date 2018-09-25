#!/bin/bash

if [[ -z "$START_TIMEOUT" ]]; then
    START_TIMEOUT=900
fi

start_timeout_exceeded=false
count=0
step=10
while netstat -lnt | awk '$4 ~ /:21000$/ {exit 1}'; do
    echo "waiting for atlas to be ready"
    sleep $step;
    count=$(expr $count + $step)
    if [ $count -gt $START_TIMEOUT ]; then
        start_timeout_exceeded=true
        break
    fi
done

if [ "$start_timeout_exceeded" = "false" ]; then
    # Setup atlas types
    printf "Creating  ingestion-source type... \n"
    curl -i -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -u admin:admin 'http://localhost:21000/api/atlas/v2/types/typedefs' -d @/tmp/model/typedef-ingestion-source.json
    printf "\ningestion-source created\n"

    # Setup atlas servicedefs
    printf "Creating file type... \n"
    curl -i -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -u admin:admin 'http://localhost:21000/api/atlas/v2/types/typedefs' -d @/tmp/model/typedef-file.json
    printf "\nfile type created\n"

    # Setup atlas services
    printf "Creating  aws_cli_process type... \n"
    curl -i -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -u admin:admin 'http://localhost:21000/api/atlas/v2/types/typedefs' -d @/tmp/model/typedef-awscli_process.json
    printf "\naws_cli_process created\n"

    echo "Done setting up Atlas types "
else
    echo "Waited too long for Atlas to start, skipping setup..."
fi
