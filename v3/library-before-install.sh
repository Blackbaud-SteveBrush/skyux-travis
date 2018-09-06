#!/usr/bin/env bash
set -e

# Make nvm available in this script.
. ~/.nvm/nvm.sh

# Necessary to stop pull requests from forks from running.
if [ "$TRAVIS_SECURE_ENV_VARS" == "true" ]; then
  nvm install-latest-npm &
  proc1=$!
  # Need to wait for the nvm subshell to finish before running the next command.
  wait "$proc1"
  npm install -g @blackbaud/skyux-cli
  skyux version
else
  echo -e "Ignoring script. Pull requests from forks are run elsewhere."
fi
