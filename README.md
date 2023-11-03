# heylisten

A Socket IO App Running on a Google Cloud Platform VM.

# Note

Not yet working. Issue with setting up VM and getting a node socket server to listen for connection.

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
