#!/bin/bash
set -e

GITHUB_USER="gituserc1140"
REPO_NAME="ReRepo"

# Use env var if set, otherwise prompt
if [ -z "$GITHUB_PERSONAL_ACCESS_TOKEN" ]; then
  echo "GITHUB_PERSONAL_ACCESS_TOKEN not found in environment."
  read -rsp "Paste your GitHub Personal Access Token: " TOKEN
  echo ""
else
  TOKEN="$GITHUB_PERSONAL_ACCESS_TOKEN"
fi

echo "Verifying token with GitHub..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" -H "Authorization: token $TOKEN" https://api.github.com/user)
if [ "$STATUS" != "200" ]; then
  echo "Token verification failed (HTTP $STATUS). Please check your token and try again."
  exit 1
fi
echo "Token verified OK."

echo "Setting git config..."
git config user.email "$GITHUB_USER@users.noreply.github.com"
git config user.name "$GITHUB_USER"

echo "Setting remote..."
git remote remove origin 2>/dev/null || true
git remote add origin "https://$GITHUB_USER:$TOKEN@github.com/$GITHUB_USER/$REPO_NAME.git"

echo "Pushing to GitHub..."
git push -u origin main

echo ""
echo "Done! View your repo at: https://github.com/$GITHUB_USER/$REPO_NAME"
