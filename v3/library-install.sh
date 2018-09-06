#!/usr/bin/env bash
set -e

# Necessary to stop pull requests from forks from running.
if [ "$TRAVIS_SECURE_ENV_VARS" == "true" ]; then
  skyux version
  npm install
  npm install --no-save blackbaud/skyux-builder-config#visual-scripts
  skyux version
else
  echo -e "Ignoring script. Pull requests from forks are run elsewhere."
fi
