#!/bin/bash

# Important: requires .com/.net zone screenshot by Verisign, called com-zone-20170501.gz

# Name Servers of IDNs
zgrep "^XN--[[:alnum:]]*[[:blank:]]*NS.*$" "../data/com-zone-20170501.gz" | gzip --best > "../data/com-zone-ns-idn-20170501.gz"

# Unique IDNs, sorted
zcat "../data/com-zone-ns-idn-20170501.gz" | cut -f1 -d " " | sort -u | gzip --best > "../data/com-zone-idn-20170501.gz"

# Domains from Alexa Top 1m which are (COM|NET) and not IDN
# CSV format:
# Rank,DOMAIN_NAME,DOMAIN_NAME.(COM|NET)
# TODO: Filter .com/.net and not IDN, create middle column
# TODO > gzip --best > com-alexa-top-not-idn.gz

# TODO: Generate file with statistics (#Lines/#Total, etc.)

# TODO: Update readme, makefiles
