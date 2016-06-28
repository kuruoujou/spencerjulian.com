#!/usr/bin/env bash

# This is ripped straight from the jekyll docs. Will hopefully modify a bit later.

set -e # halt script on error

bundle exec jekyll build
bundle exec htmlproofer ./_site --url_ignore https://www.linkedin.com/in/spencerjulian,/assets/resume.pdf
