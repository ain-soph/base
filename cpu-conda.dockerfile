FROM local0state/base:basic-conda

RUN /opt/conda/bin/conda install -qy pytorch torchvision torchaudio cpuonly -c pytorch -c=conda-forge && \
    /opt/conda/bin/conda clean -tipsy && \
    /opt/conda/bin/pip install --no-cache-dir tensorboard