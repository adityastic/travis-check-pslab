#!/bin/sh

git config --global user.name "Travis CI"
git config --global user.email "noreply@travis.com"

git clone --quiet --branch=install https://adityastic:$GITHUB_API_KEY@github.com/adityastic/travis-check-pslab install > /dev/null
cd install 

find ../dist -maxdepth 1 -type f \( -name '*.snap' -o -name '*.deb' -o -name "*.exe" \) -exec cp -v {} . \;

git checkout --orphan temporary
git add --all .
git commit -am "[Auto] Update Install Packages ($(date +%Y-%m-%d.%H:%M:%S))"
git branch -D install
git branch -m install

git push origin install --force --quiet > /dev/null
