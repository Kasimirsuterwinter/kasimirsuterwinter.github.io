# Content model

This project uses one YAML front matter schema per content type.

## `_posts` (`_posts/*.md`)

**Required keys**
- `layout`: must be `posts`
- `title`: non-empty string
- `image`: non-empty filename string (for `assets/images/`)
- `categories`: array of one or more non-empty strings

**Optional keys**
- `date`: Jekyll-compatible datetime string
- `published`: boolean
- `excerpt_separator`: non-empty string marker (commonly `"<!-- excerpt -->"`)

**Spelling rule**
- Use `excerpt_separator` (correct spelling).
- `excerpt_seperator` is invalid.

## `_work` (`_work/*.md`)

**Required keys**
- `layout`: must be `work`
- `title`: non-empty string
- `style`: non-empty slug-like string used for CSS class/id hooks
- `image`: non-empty filename string (for `assets/images/`)
- `categories`: array of one or more non-empty strings

**Optional keys**
- none currently enforced

## Pages (`index.html`, `blog.html`, `work.html`)

**Required keys**
- `layout`: must be `default`
- `title`: non-empty string
- `description`: non-empty string
- `navigation_weight`: integer
- `menu_style`: `light` or `dark`
- `background`: either `false` (default) or a non-empty string token

**Default conventions**
- `menu_style` default: `dark` (except pages that intentionally opt into `light`)
- `background` default: `false` (set a token string only when a background variant is needed)

## Enforcement

Run:

```bash
ruby scripts/validate_content_model.rb
```

The build script also runs this validator before Jekyll.
