#!/bin/bash

# Function to convert digits to words
digit_to_word() {
    case $1 in
        0) echo -n "" ;;
        1) echo -n "one " ;;
        2) echo -n "two " ;;
        3) echo -n "three " ;;
        4) echo -n "four " ;;
        5) echo -n "five " ;;
        6) echo -n "six " ;;
        7) echo -n "seven " ;;
        8) echo -n "eight " ;;
        9) echo -n "nine " ;;
    esac
}

# Function to convert tens to words
tens_to_word() {
    case $1 in
        0) echo -n "" ;;
        1) 
            case $2 in
                0) echo -n "ten " ;;
                1) echo -n "eleven " ;;
                2) echo -n "twelve " ;;
                3) echo -n "thirteen " ;;
                4) echo -n "fourteen " ;;
                5) echo -n "fifteen " ;;
                6) echo -n "sixteen " ;;
                7) echo -n "seventeen " ;;
                8) echo -n "eighteen " ;;
                9) echo -n "nineteen " ;;
            esac
            ;;
        2) echo -n "twenty " ;;
        3) echo -n "thirty " ;;
        4) echo -n "forty " ;;
        5) echo -n "fifty " ;;
        6) echo -n "sixty " ;;
        7) echo -n "seventy " ;;
        8) echo -n "eighty " ;;
        9) echo -n "ninety " ;;
    esac
}

# Function to convert a three-digit number to words
convert_to_words() {
    local num=$1
    local ones=$(($num % 10))
    local tens=$((($num / 10) % 10))
    local hundreds=$(($num / 100))
    if [ $hundreds -gt 0 ]; then
        digit_to_word $hundreds
        echo -n "hundred "
    fi
    if [ $tens -eq 1 ]; then
        tens_to_word $tens $ones
    else
        tens_to_word $tens
        digit_to_word $ones
    fi
}

# Check if the input is a number
if ! [[ $1 =~ ^[0-9]+$ ]]; then
    echo "Error: input must be a number"
    exit 1
fi

# Check if the input is within the range
if [ $1 -gt 999999 ]; then
    echo "Error: input must be less than or equal to 999,999"
    exit 1
fi

# Convert the input number to words
if [ $1 -eq 0 ]; then
    echo "zero"
else
    thousands=$(( $1 / 1000 ))
    hundreds=$(( $1 % 1000 ))
    if [ $thousands -gt 0 ]; then
        convert_to_words $thousands
        echo -n "thousand "
    fi
    convert_to_words $hundreds
fi

