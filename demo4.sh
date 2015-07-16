#!/bin/bash
if [ -d demo4 ]; then
   rm -rf demo4;
fi
mkdir demo4
cd demo4
mkdir executables

#cabal sandbox init
git clone https://github.com/armoredsoftware/protocolImplementation.git
git clone https://github.com/armoredsoftware/xenVchan.git
git clone https://github.com/armoredsoftware/tpmEmulator.git

cd protocolImplementation

for i in outerappraiser outerattester; do
  cd $i;
  cabal sandbox init;
  cabal sandbox add-source ../../tpmEmulator ../../xenVchan/VChanUtil ../shared/bytestringJSON ../shared ../appraisal ../attestation ../protoMonad ../negotiationtools
  cabal install --dependencies-only
  cabal build
  cd ..
done

cd certificateAuthority
cabal sandbox init;
cabal sandbox add-source ../../tpmEmulator ../../xenVchan/VChanUtil ../shared/bytestringJSON ../shared ../protoMonad 
cabal install --dependencies-only
cabal build
cd ..

cp outerattester/dist/build/outerAttester/outerAttester  ../executables/
cp outerappraiser/dist/build/outerAppraiser/outerAppraiser ../executables/
cp certificateAuthority/dist/build/CA/CA ../executables/

