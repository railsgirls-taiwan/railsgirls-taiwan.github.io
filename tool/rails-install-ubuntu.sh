#!/bin/bash

set -e

echo "Updates packages. Asks for your password."
sudo apt-get update -y

echo "Installs packages. Give your password when asked."
sudo apt-get install build-essential bison openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev nodejs -y

echo "Installs ImageMagick for image processing"
sudo apt-get install imagemagick --fix-missing -y

echo "Installs RVM (Ruby Version Manager) for handling Ruby installation"
curl -L get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm

echo "Installs Ruby"
rvm install 2.0.0-247
rvm use 2.0.0-247 --default

gem install bundler --no-rdoc --no-ri
gem install rails --no-rdoc --no-ri

echo "Installs text editor"
sudo apt-get install gedit -y

echo -e "\n- - - - - -\n"
echo -e "Now we are going to print some information to check that everything is done:\n"

echo -n "Should be sqlite 3.7.3 or higher: sqlite "
sqlite3 --version
echo -n "Should be rvm 1.22.3 or higher:          "
rvm --version | sed '/^.*$/N;s/\n//g' | cut -c 1-10
echo -n "Should be ruby 2.0.0-p247:                "
ruby -v | cut -d " " -f 2
echo -n "Should be Rails 4.0.0 or higher:         "
rails -v
echo -e "\n- - - - - -\n"

echo "如果版本都正確的話，全部都安裝成功了！如果有些版本不對的話，找教練一起來解決吧。

恭喜妳!"
