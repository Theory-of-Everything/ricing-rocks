# ricing-rocks

ricing-rocks is a small website and personal project to bring better accessibility and resources
to help get beginners into ricing on Unix-based and Unix-like operating systems.

## Building
ricing-rocks uses pandoc, markdown, and gnu make to generate pages.
If you want to build the site from source:

- Clone the repo
```bash
git clone https://github.com/Theory-of-Everything/ricing-rocks
cd ricing-rocks
```
all build files will be placed in `build/` in the repo root.

- Build site from source files:
```bash
make			# generate html files from source tree
```
- Other make subcommands
```
make clean		# clean all existing build files
make test		# open current build in default web browser
make sync		# sync local changes in build/ with remote server
```
