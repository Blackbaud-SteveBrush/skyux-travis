#!/usr/bin/env bash
set -e

echo -e "Blackbaud - SKY UX Travis - After Success"

function publish {

  echo -e "Publishing to NPM..."

  # If the tag includes a '-' character, we can assume it's a prerelease version.
  if [[ $TRAVIS_TAG =~ "-" ]]; then
    echo -e "Publishing to NPM with tag 'next'.";
    npm publish --access public --tag next
  else
    echo -e "Publishing to NPM with tag 'latest'.";
    npm publish --access public --tag latest
  fi

  echo -e "Successfully published to NPM.\n"

  url="https://github.com/$TRAVIS_REPO_SLUG"

  # Create a message, linking to CHANGELOG.md if it exists
  if [[ -e "CHANGELOG.md" ]]; then
    url="$url/blob/master/CHANGELOG.md"
  fi

  packageName="$(jq -r ".name" package.json)"
  notifySlack "$packageName \`$TRAVIS_TAG\` published to NPM.\n$url"
}

notifySlack() {
  if [[ -n $SLACK_WEBHOOK ]]; then
    echo -e "Notifying Slack."
    curl -X POST --data-urlencode 'payload={"text":"'"$1"'"}' $SLACK_WEBHOOK
  else
    echo -e "No webhook available for Slack notification."
  fi
}

# Necessary to stop pull requests from forks from running outside of Savage
# Publish a tag to NPM
if [[ "$TRAVIS_SECURE_ENV_VARS" == "true" && -n "$TRAVIS_TAG" ]]; then
  if [[ $NPM_TOKEN ]]; then

    echo -e "Logging in via NPM_TOKEN"
    echo "//registry.npmjs.org/:_authToken=\${NPM_TOKEN}" > .npmrc
    publish
    echo -e "Logging out via NPM_TOKEN"
    rm .npmrc

  elif [[ $NPM_PASSWORD ]]; then

    echo -e "Logging in via NPM_PASSWORD"
    echo -e "blackbaud\n$NPM_PASSWORD\nsky-savage@blackbaud.com" | npm login
    publish
    echo -e "Logging out via NPM_PASSWORD"
    npm logout

  else
    echo -e "Unable to publish to NPM as no credentials are not available"
  fi
else
  echo -e "Ignoring Script"
fi