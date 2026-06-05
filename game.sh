#!/usr/bin/env bash

MAX_GUESSES=10

echo "Select difficulty:"
echo "  1) Easy   (1–50)"
echo "  2) Medium (1–100)"
echo "  3) Hard   (1–200)"
echo ""

while true; do
    read -rp "Enter 1, 2, or 3: " choice
    case "$choice" in
        1) DIFFICULTY="Easy";   MIN=1; MAX=50;  break ;;
        2) DIFFICULTY="Medium"; MIN=1; MAX=100; break ;;
        3) DIFFICULTY="Hard";   MIN=1; MAX=200; break ;;
        *) echo "Invalid choice. Please enter 1, 2, or 3." ;;
    esac
done

echo ""
echo "Difficulty: $DIFFICULTY | Range: $MIN–$MAX | Guesses: $MAX_GUESSES"
echo ""

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
