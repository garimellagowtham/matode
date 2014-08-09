#!/bin/bash
# This script installs the ode in the right places and adds toolbox to ld.so.conf
tar -xf ode-0.11.1.tar.gz
cd ode-0.11.1
#sh autogen.sh #Generate the configure script if not already present. This is not needed since configure script is already present
./configure --enable-shared -enable-release --enable-double-precision --prefix=/usr #Sets the right options very essential
make -j `nproc` && sudo make install # Runs make with full thread capability and installs
# Done with building and installing ode 

cd .. #Go back to the parent folder Tod do other stuff
echo "${PWD}/toolbox" | sudo tee -a /etc/ld.so.conf #Adds the toolbox to the ldpath
sudo ldconfig
