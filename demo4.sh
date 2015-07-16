#!/bin/bash
PWD=`pwd`
DEMO_DIR="demo4"
EXECS="demo"

if [ -d $DEMO_DIR ]; then
   rm -rf $DEMO_DIR;
fi
mkdir -p $DEMO_DIR/$EXECS
cd $DEMO_DIR

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

cp outerattester/dist/build/outerAttester/outerAttester  ../$EXECS
cp outerappraiser/dist/build/outerAppraiser/outerAppraiser ../$EXECS
cp certificateAuthority/dist/build/CA/CA ../$EXECS

cd $PWD
# cp exectuables to every vm
#./cpScript.sh $DEMO_DIR/$EXECS


