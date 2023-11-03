# heylisten

A Socket IO App Running on a Google Cloud Platform VM.

# Note

Not yet working. Issue with setting up VM and getting a node socket server to listen for connection.

# Build new server on code push

Use Github to push new server code to remote.

pm2 takes args to watch for file changes and restart programs: https://pm2.keymetrics.io/docs/usage/quick-start/

pm2 restart app on server restart
https://stackoverflow.com/questions/33638451/pm2-doesnt-launch-my-nodejs-app-after-server-restart

# VM Setup Commands

Article: https://javascript.plainenglish.io/deploy-a-node-js-server-using-google-cloud-compute-engine-87268919de20

- sudo apt-get -y update
- sudo apt-get install -y nodejs npm
- sudo apt install git
- git clone git_repo_name
- cd repo_name
- npm install
- sudo apt-get install -y nginx
- cd /etc/nginx/sites-available
- sudo vim default

```
server {
  listen 80;
  server_name SERVER_IP_ADDRESS;

  location / {
    proxy_pass "http://127.0.0.1:8080";
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_cache_bypass $http_upgrade;
  }
}
```

- sudo service nginx restart
- cd ~/repo_name
- sudo su root
- sudo npm install -g pm2
- pm2 start server.js --watch
- pm2 startup
- pm2 save

# Automated Startup Scripts

https://cloud.google.com/compute/docs/instances/startup-scripts/linux
