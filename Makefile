# Targets:
#    docs     : generates documents
#    clusters : generates the filtered and clustered data

.PHONY: docs cluster

docs:
	cd docs && $(MAKE) all

clusters:
	cd src && $(MAKE) all
