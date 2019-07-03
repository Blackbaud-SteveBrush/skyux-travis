#!/usr/bin/env bash
set -e

# Necessary to stop pull requests from forks from running.
if [ "$TRAVIS_SECURE_ENV_VARS" == "true" ]; then

  # Allow package.json to specify a custom build script.
  if npm run | grep -q test:ci; then
    echo -e "Running custom test step... `npm run test:ci`";
    npm run test:ci
  else
    echo -e "Running `skyux test`...";
    skyux test --coverage library --platform travis
    echo -e "Done.";
    echo -e "Running `skyux build-public-library`...";
    skyux build-public-library
    echo -e "Done.";
    echo -e "Running `skyux e2e`...";
    skyux e2e --platform travis
    echo -e "Done.";
  fi
else
  echo -e "Ignoring script. Pull requests from forks are run elsewhere."
fi
