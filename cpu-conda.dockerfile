FROM local0state/base:basic-conda

RUN /opt/conda/bin/conda install -qy --all pytorch torchvision cpuonly -c pytorch && \
    /opt/conda/bin/conda clean -tipsy && \
    /opt/conda/bin/pip install --no-cache-dir --upgrade tensorboard