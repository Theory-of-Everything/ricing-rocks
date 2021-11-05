# The directories for the source files
MD_DIR      := src/
CSS_DIR     := css/
DATA_DIR	:= data/
DEFAULT_CSS := $(CSS_DIR)styles.css

# directory for the compiled html
BUILD_DIR   := build/

# Pandoc compilation extensions
BUILD_OPTS	:= +fenced_divs+link_attributes+raw_attribute+grid_tables

# host for uploading/syncing changes with remote server
UPLOAD_HOST := user@host
UPLOAD_PATH := /path/to/src

# all source files
MD_FILES    := $(shell find $(MD_DIR) -type f -name "*.md")
HTML_FILES  := $(patsubst $(MD_DIR)%.md,$(BUILD_DIR)%.html,$(MD_FILES))
CSS_FILES   := $(patsubst $(CSS_DIR)%,$(BUILD_DIR)$(CSS_DIR)%, \
			   $(wildcard $(CSS_DIR)*.css))

.PHONY: all clean sync test

all: $(CSS_FILES) $(HTML_FILES)
	cp -rf $(MD_DIR)$(DATA_DIR) $(BUILD_DIR)$(DATA_DIR)
	cp $(MD_DIR)favicon.ico $(BUILD_DIR)favicon.ico

$(BUILD_DIR)$(CSS_DIR)%.css: $(CSS_DIR)%.css
	if [ ! -d "$(@D)" ]; then mkdir -p "$(@D)"; fi
	cp $< $@

$(BUILD_DIR)%.html: $(MD_DIR)%.md
	if [ ! -d "$(@D)" ]; then mkdir -p "$(@D)"; fi
	pandoc -s -c $(shell sed 's/[^/]//g; s/\//..\//g' <<<$(@D))$(DEFAULT_CSS) -f markdown$(BUILD_OPTS) -o "$@" "$<"

$(BUILD_DIR)$(DATA_DIR)%: $(MD_DIR)$(DATA_DIR)%
	if [ ! -d "$(@D)" ]; then mkdir -p "$(@D)"; fi
	cp -r $(DATA_DIR) $(BUILD_DIR)

test: all
	xdg-open $(BUILD_DIR)index.html > /dev/null 2>&1 &

sync: $(HTML_FILES)
	rsync -rtvzP $(BUILD_DIR) $(UPLOAD_HOST):$(UPLOAD_PATH)

clean:
	rm -rf $(BUILD_DIR)
