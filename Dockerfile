FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i 's/main$/main contrib non-free non-free-firmware/' /etc/apt/sources.list && \
    apt-get update

RUN apt-get install -y --no-install-recommends firejail

RUN apt-get install -y --no-install-recommends \
    apt-utils \
    curl \
    git \
    make \
    cmake \
    software-properties-common \
    tar \
    xz-utils \
    python3-dev \
    pkg-config \
    build-essential \
    # Python3
    python3 \
    python3-pip \
    ninja-build \
    ffmpeg \
    libcairo2-dev \
    libpango1.0-dev
    
##################################################################################
### JAVA
#RUN apt-get install -y default-jdk
RUN curl -O https://download.oracle.com/java/24/latest/jdk-24_linux-x64_bin.deb \
    && dpkg -i jdk-24_linux-x64_bin.deb \
    && rm jdk-24_linux-x64_bin.deb


### Python3
# Install the latest version of meson
RUN pip3 install --upgrade meson \
    && pip3 install \
    matplotlib \
    numpy \
    opencv-python opencv-contrib-python \
    pyarrow \
    pandas \
    scipy \
    sympy \
    pyyaml \
    pycairo \
    manim


#############################################################################################
COPY . /coderunner
WORKDIR "/coderunner"

RUN pip3 install -r requirements.txt

RUN chmod u+s /usr/bin/firejail

# For some reasons firejail needs to be run multiple times to work
RUN firejail || true
RUN firejail || true
RUN firejail || true
RUN firejail || true
RUN firejail || true

RUN firejail || true
RUN firejail || true
RUN firejail || true
RUN firejail || true
RUN firejail || true

EXPOSE 4000

ENTRYPOINT ["python3","-m","server","--host","0.0.0.0","--port","4000"]
