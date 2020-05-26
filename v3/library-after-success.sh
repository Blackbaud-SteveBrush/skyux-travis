#!/usr/bin/env bash
set -e

echo -e "Blackbaud - SKY UX Travis - Library After Success"

# Necessary to stop pull requests from forks from running.
if [[ "$TRAVIS_SECURE_ENV_VARS" == "true" ]]; then

  # Save any new baseline screenshots.
  echo -e "Running visual baseline scripts from @skyux-sdk/builder..."
  node ./node_modules/@skyux-sdk/builder-config/scripts/visual-baselines.js
else
  echo -e "Ignoring script. Pull requests from forks are run elsewhere."
fi