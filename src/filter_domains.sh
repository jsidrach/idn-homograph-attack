#!/bin/bash

# Important: requires .com zone snapshot by Verisign, called com-zone-20170501.gz
if [ ! -f "../data/com-zone-20170501.gz" ]; then
  echo "Required file ../data/com-zone-20170501.gz not found"
  exit 1
fi

# Name Servers of IDNs
zgrep "^XN--[a-zA-Z0-9-]*[[:blank:]]*NS.*$" "../data/com-zone-20170501.gz" \
  | gzip --best > "../data/com-zone-ns-idn-20170501.gz"

# Unique IDNs, sorted
zcat "../data/com-zone-ns-idn-20170501.gz" \
  | cut -f1 -d " " \
  | sort -u \
  | tr '[:upper:]' '[:lower:]' \
  | gzip --best > "../data/com-zone-idn-20170501.gz"

# Domains from Alexa Top 1m which are .com and not IDN
# CSV format:
# Rank,DOMAIN_NAME
zgrep "^[[:digit:]]*,[a-zA-Z0-9-]*\.com$" "../data/alexa-top-1m-20170501.gz" \
  | grep -v "xn--" \
  | cut -f1 -d "." \
  | sort -t "," -k 2,2 -u \
  | sort -t "," -k 1n,1n \
  | gzip --best > "../data/com-alexa-top-not-idn-20170501.gz"

echo -e "Date of data screenshot: 2017-05-01" > "../data/stats-filtered-domains.txt"
NumDomains=`zcat "../data/com-alexa-top-not-idn-20170501.gz" | wc -l`
echo -e "Number of top unique .com non-IDNs:" $NumDomains >> "../data/stats-filtered-domains.txt"
NumIDNs=`zcat "../data/com-zone-idn-20170501.gz" | wc -l`
echo -e "Number of unique .com IDNs:" $NumIDNs >> "../data/stats-filtered-domains.txt"
