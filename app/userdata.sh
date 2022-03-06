#! /bin/bash -ex
# set up the linux env
sudo apt-get update
sudo apt-get install -y python3 python3-pip python3-venv libmysqlclient-dev git tmux
pip3 install flask flask-mysqldb

# set up app folder
app_folder=/home/ubuntu/flaskapp
mkdir $app_folder

# get the web app
git clone https://github.com/hypheni/flask-webapp-demo.git $app_folder
chown -R ubuntu:ubuntu $app_folder
chmod +x $app_folder/run

# execute the python app in tmux
cd $app_folder/
sudo -u ubuntu tmux new -s app-session -d
sudo -u ubuntu tmux send-keys -t app-session "./run" Enter

# set up the DB connection name
printf "" >> db-name
