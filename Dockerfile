ARG BALENA_ARCH
FROM balenalib/$BALENA_ARCH-debian:stretch-build-20190215

ARG BALENA_ARCH
ARG LLVM_ARCH

RUN [ "if [ $BALENA_ARCH != "amd64" ]; then cross-build-start; fi" ]

RUN buildDeps=' \
		curl \
		gcc \
		libbz2-dev \
		libc6-dev \
		libncurses-dev \
		libreadline-dev \
		libsqlite3-dev \
		libssl-dev \
		liblzma-dev \
		libffi-dev \
		cmake \
		make \
		xz-utils \
		zlib1g-dev \
		ca-certificates \
		patch \
	' \
	&& install_packages -y $buildDeps

ENV TAR_FILE=llvm-8.0.0.linux-$BALENA_ARCH.tar.gz

RUN wget https://releases.llvm.org/8.0.0/llvm-8.0.0.src.tar.xz \
    && tar -xf llvm-8.0.0.src.tar.xz \
    && mkdir llvm-8.0.0.src/build && cd llvm-8.0.0.src/build \
    && cmake ../ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/llvm/usr/local -DLLVM_TARGETS_TO_BUILD="${LLVM_ARCH}" \
    && make -j4 \
    && make install

RUN cd / && tar -cvzf $TAR_FILE llvm/*

RUN [ "if [ $ARCH != "amd64" ]; then cross-build-end; fi" ]