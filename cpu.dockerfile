FROM python:latest
LABEL maintainer="Ren Pang <rbp5354@psu.edu>"
LABEL org.opencontainers.image.source=https://github.com/ain-soph/base

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt update --fix-missing && \
    DEBIAN_FRONTEND="noninteractive" apt install -y apt-utils && \
    apt upgrade -y
RUN DEBIAN_FRONTEND="noninteractive" apt install -y wget bzip2 ca-certificates curl git vim tmux make tzdata && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    # Set timezone
    ln -sf /usr/share/zoneinfo/EST /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir numpy pyyaml pandas tqdm matplotlib seaborn scikit-learn tensorboard
RUN pip install --no-cache-dir torch==1.8.1+cpu torchvision==0.9.1+cpu torchaudio==0.8.1 -f https://download.pytorch.org/whl/torch_stable.html
CMD [ "/bin/bash" ]
WORKDIR /workspace/
