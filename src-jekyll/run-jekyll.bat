docker run --rm ^
  -v "%~dp0.":/srv/jekyll ^
  -v jekyll_gem_cache:/usr/local/bundle ^
  -p 4000:4000 ^
  jekyll/jekyll:latest sh -c "bundle config set path '/usr/local/bundle' && bundle install && bundle exec jekyll serve --watch --drafts --force_polling --destination /tmp/_site -H 0.0.0.0"
