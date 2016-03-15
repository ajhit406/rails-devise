#!/bin/bash

rm -rf ~/code/example

sudo apt-get update
sudo apt-get clean

cd ~/code/rails-devise

# bundle install
gem install bundler
bundle install
echo -e '\nPORT=3000\nIP=0.0.0.0' >> .env
sed -i 's|rails server|rails server -b $IP|g' Procfile

rake db:migrate
rake db:test:prepare

echo -e '#!/bin/bash\nbundle exec foreman start' >> start-app
chmod +x start-app
