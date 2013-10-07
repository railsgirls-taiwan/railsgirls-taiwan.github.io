#!/bin/bash

set -e

# If you decide to skip the full update, be sure to at least run 'sudo yum update audit -y'
echo "Updates packages. Asks for your password."
sudo yum update -y

echo "Installs packages. Give your password when asked."
sudo yum install make automake gcc gcc-c++ kernel-devel patch libffi-devel libtool bison openssl readline readline-devel curl git-core zlib zlib-devel openssl-devel libyaml-devel sqlite sqlite-devel libxml2 libxml2-devel libxslt-devel autoconf glibc-devel nodejs -y

echo "Installs ImageMagick for image processing"
sudo yum install ImageMagick -y

echo "Installs RVM (Ruby Version Manager) for handling Ruby installation"
curl -L get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm

echo "Installs Ruby"
rvm install 2.0.0-p247
rvm use 2.0.0-p247 --default

gem install bundler --no-rdoc --no-ri
gem install rails --no-rdoc --no-ri

echo "Installs text editor"
sudo yum install gedit -y

# Make sure RVM, Ruby and Rails are on the user's path
echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"' >> ~/.bashrc
set +e
source ~/.bashrc
set -e

echo -n "Should be sqlite 3.7.3 or higher: sqlite "
sqlite3 --version
echo -n "Should be rvm 1.22.3 or higher: "
rvm --version | sed '/^.*$/N;s/\n//g' | cut -c 1-10 | xargs echo
echo -n "Should be ruby 2.0.0-p247: "
ruby -v | cut -d " " -f 2
echo -n "Should be Rails 4.0.0 or higher: "
rails -v
echo -e "\n- - - - - -\n"

echo "如果版本都正確的話，全部都安裝成功了！如果有些版本不對的話，找教練一起來解決吧。

恭喜妳!"
