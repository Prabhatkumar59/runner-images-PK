#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-vcpkg.sh
##  Desc:  Install vcpkg
################################################################################

source ~/utils/utils.sh

# Set env variable for vcpkg
VCPKG_INSTALLATION_ROOT=/usr/local/share/vcpkg
echo "export VCPKG_INSTALLATION_ROOT=${VCPKG_INSTALLATION_ROOT}" | tee -a ~/.bashrc

# workaround https://github.com/microsoft/vcpkg/issues/27786

mkdir -p /Users/runner/.vcpkg
touch /Users/runner/.vcpkg/vcpkg.path.txt

# Install vcpkg
sudo git clone https://github.com/Microsoft/vcpkg $VCPKG_INSTALLATION_ROOT
sudo $VCPKG_INSTALLATION_ROOT/bootstrap-vcpkg.sh
$VCPKG_INSTALLATION_ROOT/vcpkg integrate install
sudo chmod -R 0777 $VCPKG_INSTALLATION_ROOT
ln -sf $VCPKG_INSTALLATION_ROOT/vcpkg /usr/local/bin

rm -rf /Users/runner/.vcpkg

invoke_tests "Common" "vcpkg"
