# Kasimir Suter Winter

I am an architect by training, but I have started dabling in web coding. Really enjoying it and finding alot of inspiration in the computer and network architectures. Maybe the title "architect" used in the coding world is even more acurate than that used int the actual profession of Architecture. 

My site is free to copy and personalize for your own portfolio. It is built with Jekyll and CSS grid. I had a lot of fun buildng it and learning along the way. 

I also publish articles so feel free to check out the blog at [kasimirsuterwinter.github.io/blog](kasimirsuterwinter.github.io/blog)

## Local development

This site uses the `github-pages` gem baseline.

```powershell
bundle config set --local path vendor/bundle
bundle install
bundle exec jekyll serve --host 127.0.0.1 --port 4000
```

For full build validation:

```powershell
bundle exec jekyll build
ruby scripts/validate_content_model.rb
```


