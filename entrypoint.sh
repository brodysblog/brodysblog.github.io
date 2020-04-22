#!/bin/bash
set -e

npm install -D --save autoprefixer
npm install -D --save postcss-cli

git submodule update --init --recursive

git submodule add https://${GITHUB_TOKEN}@github.com/${USER_SITE_REPOSITORY}.git public
cd public
git branch gh-pages
git checkout gh-pages
cd ..

echo "#################################################"
echo "Starting the Hugo Action"

sh -c "hugo $*"

echo "#################################################"
echo "Hugo build done"

echo "#################################################"
echo "Now publishing"
SOME_TOKEN=${GITHUB_TOKEN}

USER_NAME="${GITHUB_ACTOR}"
MAIL="${GITHUB_ACTOR}@users.noreply.github.com"

ls -ltar
cd public
ls -ltar
git log -2
git remote -v

echo "Set user data."
git config user.name "${USER_NAME}"
git config user.email "${MAIL}"

# Create CNAME file for redirect to this repository
if [[ "${CNAME}" ]]; then
  echo ${CNAME} > CNAME
fi

touch .nojekyll
echo "Add all files."
git add -A -v
git status
git diff-index --quiet HEAD || echo "Commit changes." && git commit -m 'Hugo build from Action' && echo "Push." && git push origin

echo "#################################################"
echo "Published"
