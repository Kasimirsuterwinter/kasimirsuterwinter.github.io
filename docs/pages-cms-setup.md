# Pages CMS setup for this site

This repository is now configured for [Pages CMS](https://pagescms.org/) with a root `.pages.yml` file.

## Editing workflow

- Repository: `kasimirsuterwinter.github.io`
- Branch: `main`
- Publishing mode: direct commits to `main` (single-maintainer workflow)

## Content areas in CMS

- **Site Settings** → `_config.yml` (`title`, `description`, `timezone`, `email`)
- **Home Page** → `index.html`
- **Blog Page** → `blog.html`
- **Work Page** → `work.html`
- **Blog Posts** → `_posts/*.md`
- **Work Items** → `_work/*.md`

## Media

Media uploads are configured to:

- `input: assets/images`
- `output: /assets/images`

This matches current templates where featured images are rendered from `/assets/images/...`.

## Notes

- `settings.content.merge: true` is enabled so existing non-exposed keys are preserved when saving.
- `layout` is hidden for posts and work entries to avoid accidental template changes.
- If needed later, add a second media group for documents in `assets/documents`.
