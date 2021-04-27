FROM nvidia/cuda:11.1.1-cudnn8-runtime-ubuntu20.04
LABEL maintainer="Ren Pang <rbp5354@psu.edu>"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt update --fix-missing && \
    DEBIAN_FRONTEND="noninteractive" apt install -y apt-utils && \
    apt upgrade -y
RUN DEBIAN_FRONTEND="noninteractive" apt install -y wget bzip2 ca-certificates curl git vim tmux make tzdata python3.9 python3-distutils && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    # Set timezone
    ln -sf /usr/share/zoneinfo/EST /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata
RUN wget https://bootstrap.pypa.io/get-pip.py -O get-pip.py && \
    python3.9 get-pip.py --no-cache-dir && \
    rm -f get-pip.py
RUN cd /usr/bin && \
    ln -s pdb3.9 pdb && \
    ln -s pydoc3.9 pydoc && \
    ln -s pygettext3.9 pygettext && \
    ln -s python3.9 python

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir numpy pyyaml pandas tqdm matplotlib seaborn scikit-learn tensorboard
RUN pip install --no-cache-dir torch==1.8.1+cu111 torchvision==0.9.1+cu111 torchaudio==0.8.1 -f https://download.pytorch.org/whl/torch_stable.html
CMD [ "/bin/bash" ]
WORKDIR /workspace/