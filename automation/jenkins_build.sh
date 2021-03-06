#!/bin/bash
ARCH=$1

if [[ $WORKSPACE == "" ]]; then
    echo "ERROR: No WORKSPACE set"
    exit 1
fi

case "$ARCH" in
			'amd64')
				LLVM_ARCH=X86
			;;
			'raspberrypi3')
				 LLVM_ARCH=ARM
			;;
			'imx8m-var-dart')
				LLVM_ARCH=AArch64
			;;
		esac


set -e
mkdir -p $WORKSPACE/artifacts
cd $WORKSPACE
echo "Building LLVM for architecture '$ARCH'"
# remove the crossbuild commands if needed
if [[ $ARCH == "amd64" ]]; then
    cat Dockerfile.in  | sed -e 's/RUN \[ "cross-build-start" \]//g' -e 's/RUN \[ \"cross-build-end\" \]//g' > Dockerfile
else
    cp Dockerfile.in Dockerfile
fi

docker build -t llvm-build-$ARCH --build-arg BALENA_ARCH=$ARCH --build-arg LLVM_ARCH=$LLVM_ARCH .

echo "Copying artifact..."
if [[ $(uname) == "Darwin" ]]; then
    docker run --rm -v $WORKSPACE/artifacts:/output llvm-build-$ARCH /bin/bash  -c "cp /llvm-*.tar.gz /output/"
else
    docker run --rm -v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static -v $WORKSPACE/artifacts:/output llvm-build-$ARCH /bin/bash  -c "cp /llvm-*.tar.gz /output/"
fi