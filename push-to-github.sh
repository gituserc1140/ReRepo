#!/bin/bash
set -e

GITHUB_USER="gituserc1140"
REPO_NAME="ReRepo"
TOKEN="$GITHUB_PERSONAL_ACCESS_TOKEN"

if [ -z "$TOKEN" ]; then
  echo "Error: GITHUB_PERSONAL_ACCESS_TOKEN is not set."
  exit 1
fi

echo "Setting up git config..."
git config user.email "$GITHUB_USER@users.noreply.github.com"
git config user.name "$GITHUB_USER"

echo "Setting remote..."
git remote remove origin 2>/dev/null || true
git remote add origin "https://$GITHUB_USER:$TOKEN@github.com/$GITHUB_USER/$REPO_NAME.git"

echo "Pushing to GitHub..."
git push -u origin main

echo ""
echo "Done! Your code is now on GitHub:"
echo "https://github.com/$GITHUB_USER/$REPO_NAME"
