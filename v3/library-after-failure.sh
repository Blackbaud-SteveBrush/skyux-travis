#!/usr/bin/env bash
set -e

# Necessary to stop pull requests from forks from running.
if [ "$TRAVIS_SECURE_ENV_VARS" == "true" ]; then

  if [ -d "./node_modules/@blackbaud/skyux-builder-config" ]; then
    output=$(node ./node_modules/@blackbaud/skyux-builder-config/scripts/visual-failures.js)
  else
    output=$(node ./node_modules/@skyux-sdk/builder-config/scripts/visual-failures.js)
  fi

  # Capture the script's exit code.
  # https://stackoverflow.com/questions/40774511/exit-bash-script-if-subprocess-exits-with-non-zero-code
  status=$?
  (( status )) && exit 1
else
  echo -e "Ignoring script. Pull requests from forks are run elsewhere."
fi
