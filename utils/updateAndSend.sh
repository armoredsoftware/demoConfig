#!/bin/bash
PWD=`pwd`
DEMO_DIR=$2
EXECS="demo"

if [ -z "$1" ];then
   echo "  Specify the compute node # you want to copy the executables"
   echo "  or enter 'all' in order to copy them to all compute nodes" 
   exit
fi

if [ -z "$2" ]; then
   echo " Second argument should be the demo directory e.g. demo4"
   exit
fi

cd $DEMO_DIR/protocolImplementation

cd outerappraiser
cabal build

cd ../outerAttester
cabal build

cd ../certificateAuthority
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
