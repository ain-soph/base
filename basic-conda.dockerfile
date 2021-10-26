FROM continuumio/miniconda3
LABEL maintainer="Ren Pang <rbp5354@psu.edu>"
LABEL org.opencontainers.image.source=https://github.com/ain-soph/base

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt update --fix-missing && \
    DEBIAN_FRONTEND="noninteractive" apt install -y apt-utils && \
    apt upgrade -y && \
    apt clean
RUN DEBIAN_FRONTEND="noninteractive" apt install -y wget bzip2 ca-certificates curl git vim tmux make tzdata && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    # Set timezone
    ln -sf /usr/share/zoneinfo/EST /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata
RUN conda create -qy -n py39 python=3.9 && \
    conda clean -tipsy && \
    sed -i 's/conda activate base/conda activate py39/g' ~/.bashrc
RUN /opt/conda/envs/py39/bin/pip install --no-cache-dir --upgrade pip && \
    /opt/conda/envs/py39/bin/pip install --no-cache-dir numpy pyyaml pandas tqdm matplotlib scikit-learn
CMD [ "/bin/bash" ]
WORKDIR /workspace/