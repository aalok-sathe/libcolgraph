#!/bin/bash

path_to_swig=$(which swig)
if [ -x "$path_to_swig" ] ; then
    echo "INFO swig is already installed: $path_to_swig"
    exit 0
fi

set -e

# download swig because it was not found
curl --remote-name https://gigenet.dl.sourceforge.net/project/swig/swig/swig-4.0.1/swig-4.0.1.tar.gz
tar xzvf swig-4.0.1.tar.gz
cd swig-4.0.1.tar.gz

# install locally so we dont need to ask for privileges
./configure --prefix="$HOME/.swig"
./autogen.sh
make
make install

# make it callable from anywhere
export PATH="$PATH:$HOME/.swig/bin"

# make it persistent across reboots
echo 'export PATH="$PATH:$HOME/.swig/bin"' >> ~/.bash_profile
echo 'export PATH="$PATH:$HOME/.swig/bin"' >> ~/.bashrc
source ~/.bash_profile
source ~/.bashrc

echo "INFO finished installing swig: $(which swig)"
