# Targets:
#    docs    : generates documents
#    TODO    : Rules for code, graphs

.PHONY: docs

docs:
	cd docs && $(MAKE) all
