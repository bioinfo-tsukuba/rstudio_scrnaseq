FROM rocker/tidyverse:4.3.2

# `docker build --build-arg GITHUB_PAT=YOUR_PAT ...` とすると、
ARG GITHUB_PAT

# 設定ファイルのCOPY
COPY ld.so.conf /etc/ld.so.conf
COPY myscript.R /home/rstudio/
COPY package_list.txt /home/rstudio/

# sc-type prep
RUN git clone https://github.com/IanevskiAleksandr/sc-type.git \
  && cd sc-type \
  && git checkout tags/v1.0 \
  && cd ../ \
  && mkdir -p /home/app \
  && mv sc-type /home/app/sc-type

# linux packages install
RUN sudo apt-get update \
  && sudo apt-get install libglpk40 -y \
  && sudo apt-get install libbz2-dev -y \
  && sudo apt-get install liblzma-dev -y \
  && sudo apt-get install libhdf5-dev -y \
  && sudo apt-get install libhdf5-serial-dev -y \
  && sudo apt install build-essential -y \
  && sudo apt-get install libxt6 -y \
  && sudo apt-get install libgsl-dev -y \
  && sudo apt-get install libproj-dev -y \
  && sudo apt-get install libgdal-dev -y \
  && sudo apt-get install libfftw3-dev -y \
  && sudo apt-get install libglu1-mesa-dev -y

# R packages install
RUN cd /home/rstudio/ \
  && Rscript --vanilla myscript.R $GITHUB_PAT


