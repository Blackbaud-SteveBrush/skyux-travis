#!/usr/bin/env bash
set -e

# Necessary to stop pull requests from forks from running.
if [[ "$TRAVIS_SECURE_ENV_VARS" == "true" && -n "$TRAVIS_TAG" ]]; then
  # Allow package.json to specify a custom build script.
  if npm run | grep -q build:ci; then
    echo -e "Running custom build step... `npm run build:ci`";
    npm run build:ci
  else
    skyux build-public-library
  fi

  cd dist
  bash <(curl -s https://blackbaud.github.io/skyux-travis/after-success.sh)
  node ./node_modules/@blackbaud/skyux-builder-config/scripts/visual-baselines.js
else
  echo -e "Ignoring script. Releases are published after git tag builds only."
fi
