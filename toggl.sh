#!/bin/bash

API_TOKEN="$(pass toggl)"


while getopts "s" opt; do
	case $opt in
		s)
			curr_timer_id=$(curl -u "$API_TOKEN:api_token" -X GET https://www.toggl.com/api/v8/time_entries/current | jq '.["data"]["id"]')

			if [[ "$curr_timer_id" != "null" ]]; then
				curl -u "$API_TOKEN:api_token" -d "{}" -H "Content-Type: application/json" -X PUT "https://www.toggl.com/api/v8/time_entries/$curr_timer_id/stop" > /dev/null
			fi
			;;
		\?)
			echo "Invalid option: -$OPTARG"
			;;
	esac
done


