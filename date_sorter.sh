#!/bin/bash

given_file="$1"
found_dates=()
while IFS= read -r lineContent || [[ -n "$lineContent" ]]; do
  # Finding dates in the formats needed
  possible_dates=($(echo "$lineContent" | grep -Eo '[0-9]{2}/[0-9]{2}/[0-9]{4}|[0-9]{2}-[0-9]{2}-[0-9]{4}|[0-9]{2}.[0-9]{2}.[0-9]{4}'))
  # Saving the found dates with their original formats
  for date in "${possible_dates[@]}"; do
    found_dates+=("$date")
  done
done < "$given_file"

#
arranged_dates=($(printf '%s\n' "${found_dates[@]}" | awk -F '[/.-]' '{printf("%s\t%s\t%s\t%s\n", $3, $1, $2, $0)}' | sort -k1,1n -k2,2n -k3,3n | awk '{print $4}'))
for final_date in "${arranged_dates[@]}"; do
  echo "$final_date"
done

