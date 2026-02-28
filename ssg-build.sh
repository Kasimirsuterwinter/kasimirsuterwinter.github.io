#!/usr/bin/env bash
set -euo pipefail

ruby scripts/validate_content_model.rb
bundle exec jekyll build
