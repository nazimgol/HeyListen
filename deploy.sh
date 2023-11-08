#! /bin/bash

# Arguments
# 1 GITHUB_USER
# 2 REPO_NAME

# Command
# ssh -i ~/.ssh/id_rsa root@host "bash -s" < deploy.sh GITHUB_USER REPO_NAME
# TEST: ssh -i ~/.ssh/id_rch root@linode4.rch.app "bash -s" < deploy.sh strawstack heylisten

git config --global user.name "Github Actions"
git config --global user.email "actions@github.com"

rm -rf $2

git clone https://github.com/$1/$2.git
cd $2

npm install
pm2 restart server.mjs
