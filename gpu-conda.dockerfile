FROM local0state/base:basic-conda

RUN pip install --no-cache-dir --upgrade tensorboard
RUN conda install -qy --all cudatoolkit=11.3 && \
    conda clean -afy
RUN conda install -qy --all pytorch torchvision -c pytorch && \
    conda clean -afy
