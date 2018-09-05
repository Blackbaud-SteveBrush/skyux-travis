#!/usr/bin/env bash
set -e

# Necessary to stop pull requests from forks from running
if [ "$TRAVIS_SECURE_ENV_VARS" == "true" ]; then
  npm i -g npm@6.0.1
  npm install -g @blackbaud/skyux-cli
else
  echo -e "Pull requests from forks are run via Savage."
fi
