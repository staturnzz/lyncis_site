#!/bin/zsh

if [ ! -f ./apt-ftparchive ]; then
    curl -LO https://apt.procurs.us/apt-ftparchive
    mv ./apt-ftparchive ./apt-ftparchive
    chmod +x ./apt-ftparchive
fi

rm -rf ./Packages
rm -rf ./Packages.*
rm -rf ./Contents-iphoneos-arm
rm -rf ./Contents-iphoneos-arm.*
rm -rf ./Release.gpg
rm -rf ./InRelease

./apt-ftparchive packages ./debs > ./Packages
bzip2 -c9 ./Packages > ./Packages.bz2
xz -c9 ./Packages > ./Packages.xz
gzip -c9 ./Packages > ./Packages.gz

./resources/apt-ftparchive contents ./debs > ./Contents-iphoneos-arm
bzip2 -c9 ./Contents-iphoneos-arm > ./Contents-iphoneos-arm.bz2
xz -c9 ./Contents-iphoneos-arm > ./Contents-iphoneos-arm.xz
gzip -c9 ./Contents-iphoneos-arm > ./Contents-iphoneos-arm.gz


grep -E "Origin:|Label:|Suite:|Version:|Codename:|Architectures:|Components:|Description:" ./Release > ./Base
./apt-ftparchive release ./ > ./Release
cat ./Base ./Release > ./output && mv ./output  ./Release
rm -rf ./Base

