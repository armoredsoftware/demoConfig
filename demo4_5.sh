#!/bin/bash
PWD=`pwd`
DEMO_DIR="demo4_5"
EXECS="demo"

if [ -z "$1" ];then
   echo "  Specify the compute node # you want to copy the executables"
   echo "  or enter 'all' in order to copy them to all compute nodes" 
   exit
fi

if [ -d $DEMO_DIR ]; then
   rm -rf $DEMO_DIR;
fi
mkdir -p $DEMO_DIR/$EXECS
cd $DEMO_DIR

git clone https://github.com/armoredsoftware/protocolImplementation.git
git clone https://github.com/armoredsoftware/xenVchan.git
git clone https://github.com/armoredsoftware/tpmEmulator.git
git clone https://github.com/armoredsoftware/measurer.git
git clone https://github.com/ku-fpg/remote-json.git

#Tags
cd xenVchan
git checkout tags/v0.4.5
cd ..

cd tpmEmulator
git checkout tags/v0.4.5
cd ..

cd protocolImplementation
git checkout tags/v0.4.5
cd ..

cd measurer
git checkout tags/v0.4.5
cd gdb-7.9/gdb;
./configure
cd ..
./configure 
cd ..
make configure-measurer
make build-measurer

make configure-measurer
make build-measurer
cd app
make
cd ..
cp gdb-7.9/gdb/gdb ../$EXECS 
cp app/test1.o ../$EXECS
cp app/test2.o ../$EXECS
cp app/buffer_overflow/buffer_overflow1.o ../$EXECS
cp app/buffer_overflow/buffer_overflow2.o ../$EXECS


cd ..

cd protocolImplementation

for i in outerappraiser outerattester; do
  cd $i;
  cabal sandbox init;
  cabal sandbox add-source ../../tpmEmulator ../../xenVchan/VChanUtil ../shared/bytestringJSON ../shared ../appraisal ../attestation ../protoMonad ../negotiationtools ../../remote-json ../remoteMonad ../armored-config
 
  # run one in background
  if [ "$i" == "outerappraiser" ];then
     cabal install --dependencies-only &
  else
     cabal install --dependencies-only 
  fi
  cd ..
done

cd outerappraiser
cabal build
cd ..
cd outerattester
cabal build
cd ..


cd certificateAuthority
cabal sandbox init;
cabal sandbox add-source ../../tpmEmulator ../../xenVchan/VChanUtil ../shared/bytestringJSON ../shared ../protoMonad  ../../remote-json ../remoteMonad ../armored-config
cabal install --dependencies-only
cabal build
cd ..


cp outerattester/dist/build/outerAttester/outerAttester  ../$EXECS/Attester
cp outerappraiser/dist/build/outerAppraiser/outerAppraiser ../$EXECS/Appraiser
cp certificateAuthority/dist/build/CA/CA ../$EXECS

cd ../../
cp includedFiles/common/* $DEMO_DIR/$EXECS 
cp includedFiles/demo4_5/* $DEMO_DIR/$EXECS
exit
cd $PWD
# cp exectuables to every vm
if [ "$1" != "all" ];then

   utils/cpScript.sh $DEMO_DIR/$EXECS $1

else

   utils/cpScript.sh $DEMO_DIR/$EXECS 

fi
