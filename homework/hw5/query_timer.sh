#!/bin/bash

if [ $# -ne 5 ]; then
    echo "Usage: bash query_timer.sh label num_reps query db_file csv_file"
    exit 1
fi

label=$1
num_reps=$2
query=$3
db_file=$4
csv_file=$5

SECONDS=0

for i in $(seq "$num_reps"); do
    duckdb "$db_file" "$query" > /dev/null 2>&1
done

elapsed=$SECONDS

avg_time=$(python -c "print($elapsed / $num_reps)")

echo "$label,$avg_time" >> "$csv_file"