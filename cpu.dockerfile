FROM python
LABEL maintainer="Ren Pang <rbp5354@psu.edu>"
LABEL org.opencontainers.image.source=https://github.com/ain-soph/base

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Use apt
RUN apt update --fix-missing --no-install-recommends && \
    DEBIAN_FRONTEND="noninteractive" apt install -y --no-install-recommends apt-utils && \
    apt upgrade -y --no-install-recommends && \
    # Install packages
    DEBIAN_FRONTEND="noninteractive" apt install -y --no-install-recommends wget bzip2 ca-certificates curl git vim tmux make && \
    # Set timezone
    DEBIAN_FRONTEND="noninteractive" apt install -y --no-install-recommends tzdata && \
    ln -sf /usr/share/zoneinfo/EST /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    # Clean
    apt clean && \
    rm -rf /var/lib/apt/lists/*
# Install pip packages
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir --upgrade numpy pyyaml pandas tqdm matplotlib scikit-learn tensorboard
# Install pytorch
RUN pip install --no-cache-dir --upgrade torch==1.11.0+cpu torchvision==0.12.0+cpu -f https://download.pytorch.org/whl/cpu/torch_stable.html

CMD [ "/bin/bash" ]
WORKDIR /workspace/
