# heylisten

A Socket IO App Running on a Google Cloud Platform VM. //

# Server could Pull Repo on Commit
- https://github.com/marketplace/actions/ssh-remote-commands

# Build new server on code push

Use Github to push new server code to remote.

pm2 takes args to watch for file changes and restart programs: https://pm2.keymetrics.io/docs/usage/quick-start/

pm2 restart app on server restart
https://stackoverflow.com/questions/33638451/pm2-doesnt-launch-my-nodejs-app-after-server-restart

# VM Setup Commands
- Article: https://javascript.plainenglish.io/deploy-a-node-js-server-using-google-cloud-compute-engine-87268919de20

Comands for Ubuntu 20 LTS

- sudo apt-get -y update
- sudo apt-get install -y nodejs npm
- sudo apt install git
- See `Version Control` section below
- npm install
- sudo apt-get install -y nginx
- sudo rm /etc/nginx/sites-enabled/default
- sudo ln -s ~/heylisten/socket.rch.app.conf /etc/nginx/sites-enabled/socket.rch.app.conf
- sudo service nginx restart
- cd ~/repo_name
- sudo npm install -g pm2
- pm2 start server.js --watch
- pm2 startup
- pm2 save
- sudo snap install --classic certbot
- sudo ln -s /snap/bin/certbot /usr/bin/certbot

# Github Workflow to Push Using SSH to Remote Repo
- https://dev.to/s1hofmann/github-actions-ssh-deploy-setup-l7h
- On push the .github/workflow/deploy command runs and uses rsync to send files to the remote server.

# Automated Startup Scripts

https://cloud.google.com/compute/docs/instances/startup-scripts/linux

# HTTPS/SSL Certificate Setup

https://certbot.eff.org/instructions?ws=nginx&os=ubuntufocal
