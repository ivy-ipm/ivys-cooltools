#!/data/data/com.termux/files/usr/bin/bash

chmod +x ivy.sh
cp ivy.sh $PREFIX/bin/ivy

mkdir -p $HOME/.ivy
touch $HOME/.ivy/pkgs.txt

echo "IVY ENGINE INSTALLED"
echo "run ivy h"
