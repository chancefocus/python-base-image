From alpine:3.5

MAINTAINER Jimin Huang "huangjimin@whu.edu.cn"

ENV PACKAGES="\
    dumb-init \
    bash \
    git \
    python \
    python-dev \
    openssh \
    py-mysqldb \
    curl \
    gcc \
    g++ \
    gfortran \
    build-base \
    wget \
    freetype-dev \
    libpng-dev \
    openblas-dev \
"

RUN apk update && \
    apk add --update --no-cache $PACKAGES && \
    python -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip install --upgrade pip setuptools nose && \
    rm -r /root/.cache 

RUN ln -s /usr/include/locale.h /usr/include/xlocale.h

COPY requirements.txt ./

RUN pip install -r requirements.txt
RUN pip install https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.4.0-cp27-none-linux_x86_64.whl

VOLUME ["/code"]
WORKDIR code
