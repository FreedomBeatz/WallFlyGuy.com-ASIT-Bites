#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y

cd $HOME

wget "https://dl.walletbuilders.com/download?customer=a2c37b26800abd5646e8b860ff022bd5e0f83e05aa0b53e6af&filename=asit-qt-linux.tar.gz" -O asit-qt-linux.tar.gz

mkdir $HOME/Desktop/ASIT

tar -xzvf asit-qt-linux.tar.gz --directory $HOME/Desktop/ASIT

mkdir $HOME/.asit

cat << EOF > $HOME/.asit/asit.conf
rpcuser=rpc_asit
rpcpassword=dR2oBQ3K1zYMZQtJFZeAerhWxaJ5Lqeq9J2
rpcbind=127.0.0.1
rpcallowip=127.0.0.1
listen=1
server=1
addnode=node3.walletbuilders.com
EOF

cat << EOF > $HOME/Desktop/ASIT/start_wallet.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
./asit-qt
EOF

chmod +x $HOME/Desktop/ASIT/start_wallet.sh

cat << EOF > $HOME/Desktop/ASIT/mine.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
while :
do
./asit-cli generatetoaddress 1 \$(./asit-cli getnewaddress)
done
EOF

chmod +x $HOME/Desktop/ASIT/mine.sh
    
exec $HOME/Desktop/ASIT/asit-qt &

sleep 15

cd $HOME/Desktop/ASIT/

clear

exec $HOME/Desktop/ASIT/mine.sh