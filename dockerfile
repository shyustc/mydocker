FROM ubuntu:18.10

ENV LANG C.UTF-8

RUN apt update && apt install -y \
    build-essential \
    curl \
    git \
    wget \
    libjpeg-dev \
    openjdk-8-jdk \
    gcc-7 \
    g++-7 \
    vim \
    libopenmpi-dev \
    python-opengl \
    && rm -rf /var/lib/lists/*

# Install Anaconda
WORKDIR /
RUN wget "https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh" -O "conda.sh" && \
    bash "conda.sh" -b -p "/conda" && \
    rm conda.sh && \
    echo PATH='/conda/bin:$PATH' >> /root/.bashrc && \
    /conda/bin/conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/ && \
    /conda/bin/conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/ && \
    /conda/bin/conda config --set show_channel_urls yes && \
    sed -i "s/- defaults/# - defaults/g" ~/.condarc && \
    /conda/bin/conda config --add channels conda-forge && \
    /conda/bin/conda update --yes -n base conda && \
    /conda/bin/conda update --all --yes && \
    /conda/bin/conda create -n tf20 python=3.7.3 && \
    /conda/bin/conda create -n sup python=3.6 && \
    echo "export OMPI_MCA_btl_vader_single_copy_mechanism=none #mpi for docker bug" >> ~/.bashrc && \
    echo "alias ll='ls -al'" >> ~/.bashrc && \ 
    echo "source activate sup" >> ~/.bashrc && \
    echo "export PATH='/conda/bin/:$PATH'" >> ~/.bashrc 
    
#ENV PATH /opt/conda/envs/env/bin:$PATH
ENV PATH /conda/bin:$PATH
EXPOSE 5000

# install spinningup
RUN /bin/bash -c "source ~/.bashrc && \
    source /conda/etc/profile.d/conda.sh && \
    conda activate sup && \
    conda install tensorflow && \ 
    git clone https://github.com/openai/spinningup.git && \
    cd spinningup && \
    pip install -e . -i http://pypi.douban.com/simple --trusted-host pypi.douban.com"

# 或者使用shell脚本执行
#COPY build.sh /build.sh
#COPY cuda.sh /cuda.sh
#CMD bash build.sh              
