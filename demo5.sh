#!/bin/bash
PWD=`pwd`
DEMO_DIR="demo5"
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
git clone https://github.com/ku-fpg/remote-json.git


#Tags
#cd xenVchan
#git checkout tags/v0.4
#cd ..

#cd tpmEmulator
#git checkout tags/v0.4
#cd ..

#cd protocolImplementation
#git checkout tags/v0.4


exit

for i in outerappraiser outerattester; do
  cd $i;
  cabal sandbox init;
  cabal sandbox add-source ../../tpmEmulator ../../xenVchan/VChanUtil ../shared/bytestringJSON ../shared ../appraisal ../attestation ../protoMonad ../negotiationtools ../../remote-json ../remoteMonad
 
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
cabal sandbox add-source ../../tpmEmulator ../../xenVchan/VChanUtil ../shared/bytestringJSON ../shared ../protoMonad  ../../remote-json ../remoteMonad
cabal install --dependencies-only
cabal build
cd ..


cp outerattester/dist/build/outerAttester/outerAttester  ../$EXECS
cp outerappraiser/dist/build/outerAppraiser/outerAppraiser ../$EXECS
cp certificateAuthority/dist/build/CA/CA ../$EXECS

ln -s ../$EXECS/outerAttester ../$EXECS/Attester
ln -s ../$EXECS/outerAppraiser ../$EXECS/Appraiser


cd ../../
cp includedFiles/* $DEMO_DIR/$EXECS 

cd $PWD
# cp exectuables to every vm
if [ "$1" != "all" ];then

   utils/cpScript.sh $DEMO_DIR/$EXECS $1

else

   utils/cpScript.sh $DEMO_DIR/$EXECS 

fi
