#!/usr/bin/env bash
set -euo pipefail

ruby scripts/validate_content_model.rb

if bundle exec jekyll --version >/dev/null 2>&1; then
  bundle exec jekyll build
else
  echo "WARNING: jekyll is not available in this environment."
  echo "Attempted installation is blocked by outbound 403 responses to package registries."
  echo "Run 'bundle install' in a network-enabled environment or commit vendor/cache gems for offline builds."
  exit 2
fi
