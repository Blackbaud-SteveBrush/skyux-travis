#!/usr/bin/env bash
set -e

# Necessary to stop pull requests from forks from running.
if [ "$TRAVIS_SECURE_ENV_VARS" == "true" ]; then

  # Allow package.json to specify a custom build script.
  if npm run | grep -q test:ci; then
    echo -e "Running custom test step... `npm run test:ci`";
    npm run test:ci
  else
    skyux test --coverage library --platform travis
    skyux build-public-library
    skyux e2e --platform travis
  fi
else
  echo -e "Ignoring script. Pull requests from forks are run elsewhere."
fi
