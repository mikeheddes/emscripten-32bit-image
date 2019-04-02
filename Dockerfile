# Start with 32 bit ubuntu
FROM i386/ubuntu:latest

# Install dependencies
RUN apt-get -y update \
  && apt-get -y -qq install build-essential m4 git cmake nodejs \
  default-jre python3.6 python3-distutils curl \
  && ln /usr/bin/python3.6 /usr/bin/python

WORKDIR /root

RUN git clone https://github.com/emscripten-core/emsdk.git

WORKDIR /root/emsdk

# install the emscripten dependencies en activate the environment
RUN ./emsdk install latest-32bit \
  && ./emsdk activate latest-32bit

RUN echo "source ~/emsdk/emsdk_env.sh" >> ~/.bashrc

RUN VERSION=$(echo ~/emsdk/binaryen/tag-*_32bit_binaryen) \
  && VERSION=${VERSION%_*} \
  && VERSION=${VERSION%_*} \
  && VERSION=${VERSION##*-} \
  && cp -a ~/emsdk/binaryen/tag-*_32bit_binaryen "/root/emsdk/binaryen/tag-${VERSION}_64bit_binaryen/"

WORKDIR /

CMD ["/bin/bash"]
