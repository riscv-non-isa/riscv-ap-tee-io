CONTAINER_RUNTIME ?= docker
CONTAINER_RUN := ${CONTAINER_RUNTIME} run --privileged --rm \
	-v ${PWD}:/build -w /build \
	riscvintl/riscv-docs-base-container-image:latest

HEADER_SOURCE := 00-header.adoc
PDF_RESULT := riscv-cove-io.pdf

ASCIIDOCTOR_PDF := asciidoctor-pdf
OPTIONS := --trace \
           -a compress \
           -a mathematical-format=svg \
           -a pdf-fontsdir=docs-resources/fonts \
           -a pdf-theme=docs-resources/themes/riscv-pdf.yml \
           -D build \
           --failure-level=ERROR
REQUIRES := --require=asciidoctor-bibtex \
            --require=asciidoctor-diagram \
            --require=asciidoctor-mathematical

.PHONY: all build clean build-container build-no-container

all: build

build:
	@echo "Checking if Docker is available..."
	@if command -v docker >/dev/null 2>&1 ; then \
		echo "Docker is available, building inside Docker container..."; \
		$(MAKE) build-container; \
	else \
		echo "Docker is not available, building without Docker..."; \
		$(MAKE) build-no-container; \
	fi

build-container:
	@echo "Starting build inside Docker container..."
	$(CONTAINER_RUN) /bin/sh -c "$(ASCIIDOCTOR_PDF) $(OPTIONS) $(REQUIRES) --out-file=$(PDF_RESULT) $(HEADER_SOURCE)"
	@echo "Build completed successfully inside Docker container."

build-no-container:
	@echo "Starting build..."
	$(ASCIIDOCTOR_PDF) $(OPTIONS) $(REQUIRES) --out-file=$(PDF_RESULT) $(HEADER_SOURCE)
	@echo "Build completed successfully."

clean:
	@echo "Cleaning up generated files..."
	rm -f $(PDF_RESULT)
	@echo "Cleanup completed."
