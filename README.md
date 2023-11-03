# heylisten

A Socket IO App Running on a Google Cloud Platform VM.

# Note

Not yet working. Issue with setting up VM and getting a node socket server to listen for connection.

# Build new server on code push

Use Github to push new server code to remote.

pm2 takes args to watch for file changes and restart programs: https://pm2.keymetrics.io/docs/usage/quick-start/

pm2 restart app on server restart
https://stackoverflow.com/questions/33638451/pm2-doesnt-launch-my-nodejs-app-after-server-restart

# Get Code to Google Cloud E2 VM

- https://javascript.plainenglish.io/deploy-a-node-js-server-using-google-cloud-compute-engine-87268919de20

The article above installs the following:
 
1. sudo apt-get -y update

2. sudo apt-get install -y nodejs npm

3. sudo apt install git

4. sudo apt-get install -y nginx

5. sudo npm install -g pm2

This allows a server to be run and accessed. Git is used to manually pull the code from this repo to the VM. 

# Automated Startup Scripts

https://cloud.google.com/compute/docs/instances/startup-scripts/linux
