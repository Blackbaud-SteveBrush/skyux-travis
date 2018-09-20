#!/usr/bin/env bash
set -e

# Necessary to stop pull requests from forks from running.
if [[ "$TRAVIS_SECURE_ENV_VARS" == "true" ]]; then

  # Save any new baseline screenshots.
  output=$(node ./node_modules/@blackbaud/skyux-builder-config/scripts/visual-baselines.js)

   # Capture the script's exit code.
   # https://stackoverflow.com/questions/40774511/exit-bash-script-if-subprocess-exits-with-non-zero-code
  status=$?
  (( status )) && exit 1

  # Only run releases during a git tag build.
  if [[ -n "$TRAVIS_TAG" ]]; then

    # Allow package.json to specify a custom build script.
    if npm run | grep -q build:ci; then
      echo -e "Running custom build step... `npm run build:ci`";
      npm run build:ci
    else
      skyux build-public-library
    fi

    cd dist
    bash <(curl -s https://blackbaud.github.io/skyux-travis/after-success.sh)
  else
    echo -e "Aborting release. Releases are published after git tag builds only."
  fi
else
  echo -e "Ignoring script. Pull requests from forks are run elsewhere."
fi
