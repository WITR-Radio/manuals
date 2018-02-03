MANUALS = amm trainer trainee

.PHONY: subdirs $(MANUALS) test

all: $(MANUALS)

$(MANUALS):
	$(MAKE) -C $@

test:
	echo "No tests"
