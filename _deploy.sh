#!/bin/sh

set -e

[ -z "${GITHUB_PAT}" ] && exit 0
[ "${TRAVIS_BRANCH}" != "master" ] && exit 0

git config --global user.email "lukas@quantenbrot.de"
git config --global user.name "Lukas Burk"

git clone -b gh-pages https://${GITHUB_PAT}@github.com/${TRAVIS_REPO_SLUG}.git book-output
cd book-output
cp -r ../poisson-regression/* ./
git add --all *
git commit -m "Update via travis" || true
git push -q origin gh-pages
