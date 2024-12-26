#!/usr/bin/env bash

# clean thirdparty install and compiled libraries  

# ====================================================
# import the utils 
. bash_utils.sh 

# ====================================================

set -e

print_blue "=================================================================="
print_blue "cleaning thirdparty packages and utils..."

#echo ROOT_DIR: $ROOT_DIR
cd $ROOT_DIR  # from bash_utils.sh

rm -Rf thirdparty/pangolin 

rm -Rf thirdparty/g2opy

rm -Rf thirdparty/protoc                   # set by install_delf.sh 

if [ -d "thirdparty/raft_stereo" ]; then
    rm -Rf thirdparty/raft_stereo
fi 
if [ -d "thirdparty/ml_depth_pro" ]; then
    rm -Rf thirdparty/ml_depth_pro
fi 
if [ -d "thirdparty/depth_anything_v2" ]; then
    rm -Rf thirdparty/depth_anything_v2
fi
if [ -d "thirdparty/crestereo" ]; then
    rm -Rf thirdparty/crestereo
fi
if [ -d "thirdparty/crestereo_pytorch" ]; then
    rm -Rf thirdparty/crestereo_pytorch
fi

rm -Rf thirdparty/orbslam2_features/build
rm -Rf thirdparty/orbslam2_features/lib

rm -Rf cpp/utils/build  
rm -Rf cpp/utils/lib 

if [ -d "thirdparty/opencv-python" ]; then
    rm -Rf "thirdparty/opencv-python"
fi

if [ -d "thirdparty/open3d" ]; then
    rm -Rf thirdparty/open3d
fi

if [ -d "thirdparty/opencv" ]; then
    rm -Rf thirdparty/opencv
fi

cd thirdparty/pydbow3
./clean.sh
cd $ROOT_DIR

cd thirdparty/pydbow2
./clean.sh
cd $ROOT_DIR

cd thirdparty/pyibow
./clean.sh
cd $ROOT_DIR

if [ -f "$ROOT_DIR/.env" ]; then
    echo "Removing $ROOT_DIR/.env file"
    rm "$ROOT_DIR/.env"
fi


# clean downloaded models and reset submodules
# git submodule foreach 'git reset --hard; git clean -xfd'