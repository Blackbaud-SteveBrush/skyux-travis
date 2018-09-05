#!/usr/bin/env bash
set -e

# Necessary to stop pull requests from forks from running.
if [ "$TRAVIS_SECURE_ENV_VARS" == "true" ]; then
  node ./node_modules/@blackbaud/skyux-builder-config/scripts/visual-failures.js
else
  echo -e "Ignoring script."
fi
