# Arguments
# 1 GITHUB_USER
# 2 REPO_NAME
# 3 SERVER_NAME
# 4 USER_EMAIL

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
git clone https://github.com/$1/$2.git

sudo rm /etc/nginx/sites-enabled/default

# TODO: Can we search and replace SERVER_NAME in the Nginx config?
# TEST: sed 's/SERVER_NAME_HERE/$3/g' < nginx.conf > site.nginx.conf

sudo ln -s ~/$2/site.nginx.conf /etc/nginx/sites-enabled/site.nginx.conf

sudo service nginx restart

sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot

# TODO: This command requires args passed into the script by the Github Action 
sudo certbot --noninteractive --nginx --agree-tos --cert-name certbot_cert -d $3 -m $4

# TODO: Can we access the current repo name from a Github Action in order to predict the name of the clone folder?
# Could we explicitly set the clone folder name via the git clone command?
cd ~/$2

pm2 start server.mjs
pm2 startup
pm2 save

# TODO: See above todo about the clone folder name.
cp ~/$2/deploy.sh ~/deploy.sh
chmod u+x ~/deploy.sh
