#!/bin/bash
ARCH=$1

if [[ $WORKSPACE == "" ]]; then
    echo "ERROR: No WORKSPACE set"
    exit 1
fi

set -e
mkdir -p $WORKSPACE/artifacts
cd $WORKSPACE
echo "Building LLVM for architecture '$ARCH'"
docker build -t llvm-build-$ARCH --build-arg ARCH=$ARCH  .

echo "Copying artifact..."
if [[ $(uname) == "Darwin" ]]; then
    docker run --rm -v $WORKSPACE/artifacts:/output llvm-build-$ARCH /bin/bash  -c "cp /llvm-*.tar.gz /output/"
else
    docker run --rm -v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static -v $WORKSPACE/artifacts:/output llvm-build-$ARCH /bin/bash  -c "cp /llvm-*.tar.gz /output/"
fi