FROM ubuntu:latest
LABEL maintainer="Ren Pang <rbp5354@psu.edu>"
LABEL org.opencontainers.image.source=https://github.com/ain-soph/base

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
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate py39" >> ~/.bashrc && \
    /opt/conda/bin/conda update conda --quiet -y && \
    /opt/conda/bin/conda update --all --quiet -y && \
    /opt/conda/bin/conda create -qy -n py39 python=3.9 && \
    /opt/conda/bin/conda activate py39 && \
    /opt/conda/bin/conda clean -tipsy && \
    /opt/conda/bin/conda update --all --quiet -y && \
    /opt/conda/bin/conda clean -tipsy
RUN /opt/conda/envs/py39/pip install --no-cache-dir --upgrade pip && \
    /opt/conda/envs/py39/pip install --no-cache-dir numpy pyyaml pandas tqdm matplotlib scikit-learn
CMD [ "/bin/bash" ]
WORKDIR /workspace/