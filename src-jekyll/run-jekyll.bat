@echo off
setlocal enabledelayedexpansion

rem Source content directory (outside the Jekyll root)
set "SRC=%~dp0..\src-inflated"
set "DST=%~dp0."
set "PRODUCTS=DeepGit SmartGit SmartSVN SmartSynchronize"

if exist "%SRC%" (
  echo [run-jekyll] Removing product directories in site root...
  for %%P in (%PRODUCTS%) do (
    if exist "%DST%\%%P" (
      rmdir /S /Q "%DST%\%%P"
    )
  )
  echo [run-jekyll] Copying all content from "%SRC%" to site root...
  robocopy "%SRC%" "%DST%" /E /MT:16 /R:2 /W:2 /NFL /NDL /NJH /NJS /NP >nul
  set "RC=!ERRORLEVEL!"
  if !RC! GEQ 8 (
    echo [run-jekyll] robocopy failed with code !RC!
    exit /b !RC!
  )
) else (
  echo [run-jekyll] WARN: Source folder not found: "%SRC%". Skipping copy.
)

docker run --rm ^
  -v "%~dp0.":/srv/jekyll ^
  -v jekyll_gem_cache:/usr/local/bundle ^
  -p 4000:4000 ^
  jekyll/jekyll:latest sh -c "bundle config set path '/usr/local/bundle' && bundle install && bundle exec jekyll serve --watch --drafts --force_polling --destination /tmp/_site -H 0.0.0.0"
