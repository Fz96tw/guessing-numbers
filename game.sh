#!/usr/bin/env bash

MAX_GUESSES=10
MIN=1
MAX=100

number=$(( RANDOM % MAX + MIN ))
guesses=0

echo "Guess the number between $MIN and $MAX. You have $MAX_GUESSES attempts."
echo ""

while [ $guesses -lt $MAX_GUESSES ]; do
    guesses=$(( guesses + 1 ))
    read -rp "Guess $guesses/$MAX_GUESSES: " input

    if ! [[ "$input" =~ ^[0-9]+$ ]]; then
        echo "Please enter a valid number."
        guesses=$(( guesses - 1 ))
        continue
    fi

    guess=$input

    if [ "$guess" -eq "$number" ]; then
        echo "Correct! You guessed it in $guesses guess(es)."
        exit 0
    elif [ "$guess" -lt "$number" ]; then
        echo "Too low."
    else
        echo "Too high."
    fi
done

echo "Out of guesses! The number was $number."
exit 1
