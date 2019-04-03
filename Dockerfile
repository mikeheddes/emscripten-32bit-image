# Start with 32 bit ubuntu
FROM i386/ubuntu:latest

# Install dependencies
RUN apt-get -y update \
  && apt-get -y -qq install build-essential m4 git cmake nodejs npm \
  default-jre python3.6 python3-distutils curl

WORKDIR /root

RUN git clone https://github.com/emscripten-core/emsdk.git

WORKDIR /root/emsdk

# Install the emscripten dependencies and activate
RUN ./emsdk install sdk-tag-1.38.30-32bit \
  && ./emsdk activate sdk-tag-1.38.30-32bit

# Copy folder to the by emscripten expected location
RUN cp -a /root/emsdk/binaryen/tag-1.38.30_32bit_binaryen /root/emsdk/binaryen/tag-1.38.30_64bit_binaryen

# Set environment variables
ENV PATH="${PATH}:/root/emsdk"
ENV PATH="${PATH}:/root/emsdk/clang/tag-e1.38.30/build_tag-e1.38.30_32/bin"
ENV PATH="${PATH}:/root/emsdk/node/8.9.1_32bit/bin"
ENV PATH="${PATH}:/root/emsdk/emscripten/tag-1.38.30"
ENV PATH="${PATH}:/root/emsdk/binaryen/tag-1.38.30_64bit_binaryen/bin"

ENV EMSDK="/root/emsdk"
ENV EM_CONFIG="/root/.emscripten"
ENV LLVM_ROOT="/root/emsdk/clang/tag-e1.38.30/build_tag-e1.38.30_32/bin"
ENV EMSDK_NODE="/root/emsdk/node/8.9.1_32bit/bin/node"
ENV EMSCRIPTEN="/root/emsdk/emscripten/tag-1.38.30"
ENV EMSCRIPTEN_NATIVE_OPTIMIZER="/root/emsdk/emscripten/tag-1.38.30_32bit_optimizer/optimizer"
ENV BINARYEN_ROOT="/root/emsdk/binaryen/tag-1.38.30_64bit_binaryen"

WORKDIR /

CMD ["/bin/bash"]
