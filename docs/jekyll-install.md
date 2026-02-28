# Jekyll install notes for restricted environments

This repository uses Jekyll 3.8 via Bundler.

## What was attempted here

- `bundle exec jekyll --version`
- `bundle install`
- `apt-get update`
- `apt-get install -y ruby-jekyll`

In this environment, outbound requests to package registries are blocked with `403 Forbidden`, so Jekyll cannot be installed from Rubygems or apt mirrors.

## How to run full build checks

In a network-enabled environment:

```bash
bundle install
bundle exec jekyll build
```

For fully offline CI/workspaces, vendor gems in a connected machine and commit/cache them:

```bash
bundle config set path vendor/bundle
bundle cache
```

Then install using local cache in restricted environments:

```bash
bundle install --local
bundle exec jekyll build
```

## Lightweight check available here

You can still validate front matter schema without Jekyll:

```bash
ruby scripts/validate_content_model.rb
```

Or run the combined helper:

```bash
scripts/run_checks.sh
```
