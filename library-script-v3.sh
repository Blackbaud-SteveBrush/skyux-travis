#!/usr/bin/env bash
set -e

# Necessary to stop pull requests from forks from running.
if [ "$TRAVIS_SECURE_ENV_VARS" == "true" ]; then
  npm run test:ci
  npm run test:visual:ci
else
  echo -e "Pull requests from forks are run via Savage."
fi
