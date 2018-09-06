#!/usr/bin/env bash
set -e

# Necessary to stop pull requests from forks from running.
if [ "$TRAVIS_SECURE_ENV_VARS" == "true" ]; then
  skyux test --coverage library --logFormat none --platform travis
  skyux build-public-library
  skyux e2e --platform travis --logFormat none
else
  echo -e "Ignoring script. Pull requests from forks are run elsewhere."
fi
