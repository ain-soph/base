FROM local0state/base:basic-conda

RUN pip install --no-cache-dir --upgrade tensorboard
RUN conda install -qy --all pytorch torchvision pytorch-cuda=11.7 -c pytorch -c nvidia && \
    conda clean -tipsy
