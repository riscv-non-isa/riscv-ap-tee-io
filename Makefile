spec-folder := specification

.PHONY: all spec clean
all: spec

spec: $(spec-folder)
	$(MAKE) --directory=$^

clean: $(spec-folder)
	$(MAKE) --directory=$? clean
