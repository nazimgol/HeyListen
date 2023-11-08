# TODO: Can we pass args from Github Action to a script that will be run remotely?
# TEST: ssh -i id_rch root@host "bash -s" < init.sh {{ secret }} {{ secret }}

sudo apt-get -y update

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion" # This loads nvm bash_completion
nvm install 18 && nvm use 18

sudo apt-get install -y npm
sudo apt install git
sudo apt-get install -y nginx
sudo npm install -g pm2

# TODO: Can we get the current repo HTTPS url during a Github Action?
git clone https://github.com/strawstack/heylisten.git

sudo rm /etc/nginx/sites-enabled/default

# TODO: Can we search and replace SERVER_NAME in the Nginx config?
# TEST: sed 's/SERVER_NAME/test.rch.app/g' < nginx.conf > site.nginx.conf

sudo ln -s ~/heylisten/site.nginx.conf /etc/nginx/sites-enabled/site.nginx.conf

sudo service nginx restart

sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot

# TODO: This command requires args passed into the script by the Github Action 
sudo certbot --noninteractive --nginx --agree-tos --cert-name https_cert -d ARG_DOMAIN -m ARG_EMAIL

# TODO: Can we access the current repo name from a Github Action in order to predict the name of the clone folder?
# Could we explicitly set the clone folder name via the git clone command?
cd ~/heylisten

pm2 start server.mjs
pm2 startup
pm2 save

# TODO: See above todo about the clone folder name.
cp ~/heylisten/deploy.sh ~/deploy.sh
chmod u+x ~/deploy.sh
