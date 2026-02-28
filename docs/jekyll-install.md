# Jekyll install notes (Windows + GitHub Pages baseline)

This repository uses the `github-pages` gem as the source of truth for the Jekyll dependency set.

## Runtime baseline

- Ruby: `3.2.x`
- Bundler: `2.x`
- Install path: `vendor/bundle` (local to repo)

## Windows setup

1. Install Ruby 3.2 with DevKit:
   - `winget install --id RubyInstallerTeam.RubyWithDevKit.3.2 --exact`
2. Open a new PowerShell and verify:
   - `ruby --version`
   - `bundle --version`
3. Install gems:

```powershell
bundle config set --local path vendor/bundle
bundle install
```

## Local development commands

Build once:

```powershell
bundle exec jekyll build
```

Serve locally (default/recommended):

```powershell
bundle exec jekyll serve --host 127.0.0.1 --port 4000
```

Optional best-effort livereload:

```powershell
bundle exec jekyll serve --livereload --host 127.0.0.1 --port 4000
```

## Quality checks

Front matter/content model check:

```powershell
ruby scripts/validate_content_model.rb
```

Combined checks:

```bash
scripts/run_checks.sh
```

## Troubleshooting

- `tzinfo` or timezone errors on Windows:
  - This repo includes `tzinfo-data` for Windows platforms; run `bundle install` again after pulling latest changes.
- File watching feels slow or polling-heavy:
  - `wdm` is included for Windows to improve watch behavior.
- `--livereload` issues on older Windows/Ruby combinations:
  - Use plain `bundle exec jekyll serve` as the stable default.
  - If needed, force polling: `bundle exec jekyll serve --force_polling`.
- Fully offline environment:
  - In a connected environment: `bundle cache`
  - Offline install: `bundle install --local`

## Future migration option

If native GitHub Pages constraints become limiting, an Actions-based deploy can use a newer, fully controlled Jekyll/Ruby toolchain while keeping the same site content.
