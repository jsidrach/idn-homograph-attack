#!/bin/bash

# Important: requires whois unix command
# Important: requires clustered IDNs file, called ../data/clustered-idns-20170501.csv
if [ ! -f "../data/clustered-idns-20170501.csv" ]; then
  echo "Required file ../data/clustered-idns-20170501.csv not found"
  exit 1
fi

# CSV Header
printf "Rank\tDomain (Canonical)\tDomain (Unicode)\tDomain (Punycode)\tRegistrant Organization\tRegistrant Email\tCreation Date\tUpdated Date\n"

# One row per domain
while IFS="," read rank domain unicode punycode; do
    info="$(whois $punycode.com 2>&1)"
    org="$(echo "$info" | grep -e "^Registrant Organization: " | cut -d " " -f 3-)"
    email="$(echo "$info" | grep -e "^Registrant Email: " | cut -d " " -f 3-)"
    cdate="$(echo "$info" | grep -e "^Creation Date: " | cut -d " " -f 3-)"
    udate="$(echo "$info" | grep -e "^Updated Date: " | cut -d " " -f 3-)"
    printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n" "$rank" "$domain" "$unicode" "$punycode" "$org" "$email" "$cdate" "$udate"
    sleep 1s
done < "../data/clustered-idns-20170501.csv"
