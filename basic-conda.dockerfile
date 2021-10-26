FROM continuumio/miniconda3
LABEL maintainer="Ren Pang <rbp5354@psu.edu>"
LABEL org.opencontainers.image.source=https://github.com/ain-soph/base

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt update --fix-missing --no-install-recommends && \
    DEBIAN_FRONTEND="noninteractive" apt install -y --no-install-recommends apt-utils && \
    apt upgrade -y --no-install-recommends && \
    apt clean
RUN DEBIAN_FRONTEND="noninteractive" apt install -y --no-install-recommends wget bzip2 ca-certificates curl git vim tmux make tzdata && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    # Set timezone
    ln -sf /usr/share/zoneinfo/EST /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata
RUN conda update -qy --all && \
    conda clean -tipsy && \
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir --upgrade numpy pyyaml pandas tqdm matplotlib scikit-learn
CMD [ "/bin/bash" ]
WORKDIR /workspace/