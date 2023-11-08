#! /bin/bash

# Arguments
# 1 GITHUB_USER
# 2 REPO_NAME

git config --global user.name "Github Actions"
git config --global user.email "actions@github.com"

rm -rf $2

git clone https://github.com/$1/$2.git
cd $2

npm install
pm2 restart server.mjs
