FROM resin/rpi-raspbian:jessie-20170111

ENV APT_UPDATED_AT=20170216
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y \
  git \
  openjdk-7-jdk \
  pandoc \
  r-recommended \
  wget

WORKDIR /tmp

RUN git clone https://github.com/rstudio/rstudio.git

RUN apt-get update
RUN cd ./rstudio/dependencies/linux/ && ./install-dependencies-debian || echo "Skiping the failure"
RUN cd ./rstudio/dependencies/common/ && ./install-common

#tried to make install, hangs at "ext:" so I tried installing the latest GWT
RUN wget http://dl.google.com/closure-compiler/compiler-latest.zip
RUN unzip compiler-latest.zip
RUN mv closure-compiler-v20170124.jar ./rstudio/src/gwt/tools/compiler/compiler.jar

RUN mkdir ./rstudio/build
RUN cd rstudio && cmake -DRSTUDIO_TARGET=Server -DCMAKE_BUILD_TYPE=Release
RUN cd rstudio && make install
