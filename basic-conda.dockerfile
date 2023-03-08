FROM continuumio/miniconda3
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
# Update conda packages
RUN conda install -qy python=3.10.9 -c conda-forge && \
    conda update -qy --all -c conda-forge && \
    conda clean -tipsy
# Install pip packages
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir --upgrade numpy pyyaml pandas tqdm matplotlib scikit-learn

CMD [ "/bin/bash" ]
WORKDIR /workspace/
