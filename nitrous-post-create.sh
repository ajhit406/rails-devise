#!/bin/bash

rm -rf ~/code/example

sudo apt-get update
sudo apt-get clean

cd ~/code/rails-devise

# requires ruby 2.2.3
rbenv install 2.2.3
rbenv global 2.2.3

# bundle install
gem install bundler
bundle install
echo -e '\nPORT=3000\nIP=0.0.0.0' >> .env
sed -i 's|rails server|rails server -b $IP|g' Procfile

rake db:migrate
rake db:test:prepare

echo -e '#!/bin/bash\nbundle exec foreman start' >> start-app
chmod +x start-app
