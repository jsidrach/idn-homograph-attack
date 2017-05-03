# TODO: Phony, all, document commands, domain grouping code

confusables: generate_confusables.go ../data/confusables.txt
	go run generate_confusables.go

filter-domains: filter-domains.sh
	./filter-domains.sh
