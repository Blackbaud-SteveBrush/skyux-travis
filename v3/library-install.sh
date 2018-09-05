#!/usr/bin/env bash
set -e

# Necessary to stop pull requests from forks from running.
if [ "$TRAVIS_SECURE_ENV_VARS" == "true" ]; then
  npm install
  npm install --no-save blackbaud/skyux-builder-config#visual-scripts
else
  echo -e "Pull requests from forks are run via Savage."
fi
