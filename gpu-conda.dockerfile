FROM local0state/base:basic-conda

RUN /opt/conda/bin/conda install -qy --all pytorch torchvision cudatoolkit=11.3 -c pytorch && \
    /opt/conda/bin/conda clean -tipsy && \
    /opt/conda/bin/pip install --no-cache-dir --upgrade tensorboard