FROM ubuntu:latest
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
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    /opt/conda/bin/conda install -qy python=3.9 && \
    /opt/conda/bin/conda update -aqy && \
    /opt/conda/bin/conda install -qy pytorch torchvision torchaudio cpuonly -c pytorch -c=conda-forge && \
    /opt/conda/bin/conda clean -tipsy && \
    /opt/conda/bin/conda clean -aqy && \
    /opt/conda/bin/pip install --no-cache-dir --upgrade pip && \
    /opt/conda/bin/pip install --no-cache-dir sphinx sphinxcontrib.katex numpy pyyaml pandas tqdm matplotlib seaborn scikit-learn setuptools wheel pep517 twine
ENV TINI_VERSION v0.16.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]
WORKDIR /workspace/