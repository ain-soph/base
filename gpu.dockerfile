FROM nvidia/cuda:11.3.1-cudnn8-runtime-ubuntu20.04
LABEL maintainer="Ren Pang <rbp5354@psu.edu>"
LABEL org.opencontainers.image.source=https://github.com/ain-soph/base

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Use apt
RUN apt update --fix-missing --no-install-recommends && \
    DEBIAN_FRONTEND="noninteractive" apt install -y --no-install-recommends apt-utils && \
    apt upgrade -y --no-install-recommends && \
    # Install packages
    DEBIAN_FRONTEND="noninteractive" apt install -y --no-install-recommends python3.10 python3-distutils wget bzip2 ca-certificates curl git vim tmux make && \
    # Set timezone
    DEBIAN_FRONTEND="noninteractive" apt install -y --no-install-recommends tzdata && \
    ln -sf /usr/share/zoneinfo/EST /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    # Clean
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Install python
RUN wget https://bootstrap.pypa.io/get-pip.py -O get-pip.py && \
    python3.10 get-pip.py --no-cache-dir && \
    rm -f get-pip.py && \
    cd /usr/bin && \
    ln -s pdb3.10 pdb && \
    ln -s pydoc3.10 pydoc && \
    ln -s pygettext3.10 pygettext && \
    ln -s python3.10 python

# Install pip packages
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir --upgrade numpy pyyaml pandas tqdm matplotlib scikit-learn tensorboard
# Install pytorch
RUN pip install --no-cache-dir --upgrade torch==1.11.0+cu113 torchvision==0.12.0+cu113 -f https://download.pytorch.org/whl/cu113/torch_stable.html

CMD [ "/bin/bash" ]
WORKDIR /workspace/
