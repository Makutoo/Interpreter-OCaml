SUBMIT := src/
ZIPNAME := SA2_SOOL.zip

all:
	dune build

.PHONY: test
test:
	dune runtest

zip: $(SUBMIT)
	zip '$(ZIPNAME)' -r $(SUBMIT)

.PHONY: clean
clean:
	dune clean
