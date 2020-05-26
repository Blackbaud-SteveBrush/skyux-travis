#!/usr/bin/env bash
set -e

echo -e "Blackbaud - SKY UX Travis - Library After Success"

# Necessary to stop pull requests from forks from running.
if [[ "$TRAVIS_SECURE_ENV_VARS" == "true" ]]; then

  # Save any new baseline screenshots.
  if [ -d "./node_modules/@skyux-sdk/builder" ]; then
    echo -e "Running visual baseline scripts from @skyux-sdk/builder..."
    output=$(node ./node_modules/@skyux-sdk/builder-config/scripts/visual-baselines.js) || exit
  else
    echo -e "Running visual baseline scripts from @blackbaud/skyux-builder-config..."
    output=$(node ./node_modules/@blackbaud/skyux-builder-config/scripts/visual-baselines.js) || exit
  fi

  # Only run releases during a git tag build.
  if [[ -n "$TRAVIS_TAG" ]]; then

    # Allow package.json to specify a custom build script.
    if npm run | grep -q build:ci; then
      echo -e "Running custom build step... `npm run build:ci`";
      npm run build:ci
    else
      echo -e "Building the library via `skyux build-public-library`..."
      skyux build-public-library
    fi

    cd dist
    bash <(curl -s https://blackbaud.github.io/skyux-travis/after-success.sh)
  else
    echo -e "Aborting release. Releases are published after git tag builds only."
  fi
else
  echo -e "Ignoring script. Pull requests from forks are run elsewhere."
fi