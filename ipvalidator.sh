#!/bin/bash

ip=$1

# use grep to check if the IP address matches the pattern of a valid IP
if echo $ip | grep -Eq '^(([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.){3}([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$'; then
    echo "valid"
else
    echo "invalid"
fi

#[200~^ - The ^ symbol matches the beginning of a string, ensuring that the IP address starts at the beginning of the input.
#( and ) - Parentheses are used to group parts of the expression together.
#([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5]) - This part matches each of the four numbers in the IP address. It allows for either a single digit (0-9), two digits (00-99), or three digits (000-255) to be matched. The expression is broken down as follows:
#[01]? matches either 0 or 1, zero or one time.
#[0-9]? matches any digit (0-9), zero or one time.
#[0-9] matches any digit (0-9), exactly one time.
#2[0-4][0-9] matches any number starting with 2, followed by a digit between 0 and 4, and then any digit (0-9). This allows for values from 200 to 249 to be matched.
#25[0-5] matches the numbers 250 to 255.
#\. - The backslash (\) is used to escape the period (.), which is a special character in regular expressions. This allows the period to be matched literally as a dot character in the IP address.
#{3} - The curly braces are used to specify how many times the previous group should be matched. In this case, we want to match three occurrences of the previous group (i.e. three numbers followed by a period).
#	$ - The $ symbol matches the end of a string, ensuring that there are no characters after the IP address.
#	Finally, the grep -Eq command is used to test whether the input matches the regular expression, and returns 0 if it matches (which means true) and non-zero if it does not (which means false).
