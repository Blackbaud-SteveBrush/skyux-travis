#!/usr/bin/env bash
set -e

# Necessary to stop pull requests from forks from running.
if [ "$TRAVIS_SECURE_ENV_VARS" == "true" ]; then

  # NPM versions less than v6 overwrite modules with subsequent installs.
  # (NPM version 6.0.1 will work nicely with our version of Node.js.)
  # See: https://github.com/npm/npm/issues/17379
  npm install -g npm@6.0.1

  npm install -g @blackbaud/skyux-cli
  skyux version
else
  echo -e "Ignoring script. Pull requests from forks are run elsewhere."
fi
