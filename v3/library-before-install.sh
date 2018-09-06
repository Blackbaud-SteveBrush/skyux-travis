#!/usr/bin/env bash
set -e

# Make nvm available in this script.
. ~/.nvm/nvm.sh

# Necessary to stop pull requests from forks from running.
if [ "$TRAVIS_SECURE_ENV_VARS" == "true" ]; then
  nvm install-latest-npm
  npm install -g @blackbaud/skyux-cli
  skyux --version
else
  echo -e "Ignoring script. Pull requests from forks are run elsewhere."
fi
