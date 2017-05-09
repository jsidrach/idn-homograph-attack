# Targets:
#    confusables : generates confusables map
#    filter      : filters raw data
#    cluster     : clusters homograph IDNs
#    whois       : retrieves homograph IDNs WHOIS information

all: confusables filter cluster

confusables: homographs/generate_confusables.go ../data/confusables.txt
	go run homographs/generate_confusables.go

filter: filter_domains.sh
	./filter_domains.sh

cluster: cluster_homographs.go ../data/com-zone-idn-20170501.gz ../data/com-alexa-top-not-idn-20170501.gz
	go run cluster_homographs.go > ../data/clustered-idns-20170501.csv 2> ../data/stats-clustered-domains.txt

whois: whois_homographs.sh ../data/clustered-idns-20170501.csv
	./whois_homographs.sh > ../data/clustered-idns-whois-20170501.csv
