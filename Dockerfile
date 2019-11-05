ARG ARCH
FROM balenalib/$ARCH-debian:stretch-build-20190215

ARG ARCH

RUN [ "if [ $ARCH != "amd64" ]; then cross-build-start; fi" ]

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

ENV PYTHON_VERSION 3.6.8
RUN set -e \
    && wget https://nyc3-download-01.motesque.com/packages/Python-$PYTHON_VERSION.linux-$ARCH.tar.gz \
    && tar -zxvf Python-$PYTHON_VERSION.linux-$ARCH.tar.gz  --strip-components=1 \
    && rm Python-$PYTHON_VERSION.linux-$ARCH.tar.gz \
    && ldconfig

ENV TAR_FILE=llvm-8.0.0.linux-$ARCH.tar.gz

RUN wget https://releases.llvm.org/8.0.0/llvm-8.0.0.src.tar.xz \
    && tar -xf llvm-8.0.0.src.tar.xz \
    && mkdir llvm-8.0.0.src/build && cd llvm-8.0.0.src/build \
    && cmake ../ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/llvm/usr/local -DLLVM_TARGETS_TO_BUILD="X86" \
    && make -j4 \
    && make install

RUN cd / && tar -cvzf $TAR_FILE llvm/*

RUN [ "if [ $ARCH != "amd64" ]; then cross-build-end; fi" ]