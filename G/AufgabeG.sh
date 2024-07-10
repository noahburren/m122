#!/bin/bash

API_KEY="bb9ddd1855e84ded5fca04e0"
API_URL="https://v6.exchangerate-api.com/v6/$API_KEY/latest/CHF"
DATA_FILE="exchange_data.json"
OLD_DATA_FILE="old_exchange_data.json"

# Fetch current exchange rates
fetch_exchange_rates() {
    response=$(curl -s $API_URL)
    echo $response | jq '.conversion_rates'
}

# Save data to file
save_data() {
    echo $1 > $DATA_FILE
}

# Load data from file
load_data() {
    if [ -f "$DATA_FILE" ]; then
        cat $DATA_FILE
    else
        echo "{}"
    fi
}

# Display data in tabular format
display_data() {
    echo -e "Currency\tOld Rate\tNew Rate\tChange"
    echo "$1" | jq -r 'to_entries[] | "\(.key)\t\(.value)"' | while read -r new_rate; do
        currency=$(echo $new_rate | awk '{print $1}')
        new_value=$(echo $new_rate | awk '{print $2}')
        old_value=$(echo "$2" | jq -r --arg currency "$currency" '.[$currency]')
        old_value=${old_value:-$new_value}
        change=$(echo "scale=4; $new_value - $old_value" | bc)
        change_pct=$(echo "scale=4; ($change / $old_value) * 100" | bc)
        if (( $(echo "$change > 0" | bc -l) )); then
            color="\033[92m" # green
        elif (( $(echo "$change < 0" | bc -l) )); then
            color="\033[91m" # red
        else
            color="\033[0m" # default
        fi
        echo -e "$currency\t$old_value\t$new_value\t${color}${change_pct}%\033[0m"
    done
}

# Main function
main() {
    amount=$1
    if [ -z "$amount" ]; then
        echo "Please provide an amount in CHF."
        exit 1
    fi

    current_data=$(fetch_exchange_rates)
    old_data=$(load_data)

    display_data "$current_data" "$old_data"
    save_data "$current_data"
}

main "$1"
