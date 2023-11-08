# Arguments
# 1 GITHUB_USER
# 2 REPO_NAME
# 3 SERVER_NAME
# 4 USER_EMAIL

# Run Command
# ssh -i id_rsa root@host "bash -s" < init.sh GITHUB_USER REPO_NAME SERVER_NAME USER_EMAIL
# TEST: ssh -i ~/.ssh/id_rch root@linode4.rch.app "bash -s" < init.sh strawstack heylisten linode4.rch.app rhshadowgreen@gmail.com

if test -f ~/deploy.sh; then
    echo "deploy.sh found"
    exit 0
fi
echo "deploy.sh not found"

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

# TODO: Can we access the current repo name from a Github Action in order to predict the name of the clone folder?
# Could we explicitly set the clone folder name via the git clone command?
cd ~/$2

servername=$3
sed "s/SERVER_NAME_HERE/${servername}/g" < nginx.conf > site.nginx.conf

sudo ln -s ~/$2/site.nginx.conf /etc/nginx/sites-enabled/site.nginx.conf

sudo service nginx restart

sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot

# TODO: This command requires args passed into the script by the Github Action
sudo certbot --noninteractive --nginx --agree-tos --cert-name certbot_cert -d $3 -m $4

npm install

pm2 start server.mjs
pm2 startup
pm2 save

# TODO: See above todo about the clone folder name.
cp ~/$2/deploy.sh ~/deploy.sh
chmod u+x ~/deploy.sh
