FROM local0state/base:basic-conda

RUN pip install --no-cache-dir --upgrade tensorboard
RUN conda install -qy --all pytorch torchvision cpuonly -c pytorch && \
    conda clean -tipsy