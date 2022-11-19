PANDOC_OPTS=--standalone --template=template.html

all: index.html

index.html: index.md
	pandoc $(PANDOC_OPTS) $< -o $@

watch: index.md
	fswatch -o --event Updated $< | xargs -n1 -I{} sh -c "echo Rebuilding...; pandoc $(PANDOC_OPTS) index.md -o index.html"
