#! /bin/bash

# Setup

# chmod u+x deploy.sh
# ./deploy.sh

# git config --global user.name "Github Actions"
# git config --global user.email "actions@github.com"
# git clone https://github.com/strawstack/heylisten.git

# pm2 start server.js --watch
# pm2 startup
# pm2 save

git config --global user.name "Github Actions"
git config --global user.email "actions@github.com"
rm -rf heylisten
git clone https://github.com/strawstack/heylisten.git
cd heylisten
npm install
pm2 restart server.js