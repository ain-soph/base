FROM nvidia/cuda:11.1-cudnn8-devel-ubuntu20.04
LABEL maintainer="Ren Pang <rbp5354@psu.edu>"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt update --fix-missing && \
    DEBIAN_FRONTEND="noninteractive" apt install -y apt-utils && \
    apt upgrade -y
RUN DEBIAN_FRONTEND="noninteractive" apt install -y wget bzip2 ca-certificates curl git vim tmux make tzdata && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    # Set timezone
    ln -sf /usr/share/zoneinfo/EST /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata
RUN DEBIAN_FRONTEND="noninteractive" apt install -y python3.9 python3.9-distutils && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.9 get-pip.py && \
    rm get-pip.py
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir numpy pyyaml pandas tqdm matplotlib seaborn scikit-learn tensorboard
RUN pip install --no-cache-dir torch==1.8.0+cu111 torchvision==0.9.0+cu111 torchaudio==0.8.0 -f https://download.pytorch.org/whl/torch_stable.html
CMD [ "/bin/bash" ]
WORKDIR /workspace/