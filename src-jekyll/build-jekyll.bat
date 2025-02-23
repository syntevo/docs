docker run --rm ^
  -v "%~dp0.":/srv/jekyll ^
  -v jekyll_gem_cache:/usr/local/bundle ^
  -v "%~dp0.out":/tmp/_site ^
  jekyll/jekyll:latest sh -c "bundle config set path '/usr/local/bundle' && bundle install && bundle exec jekyll build --destination /tmp/_site --verbose"
