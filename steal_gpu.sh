#yum -y update

#yum clean all
#yum list
#yum makecache

#yum install  curl git wget htop #xorg-x11-xauth.x86_64 htop xorg-x11-apps.x86_64

# for local conda
yum  install gcc gcc-c++ gcc-gfortran openssl-devel libffi-devel python-pip python-devel atlas atlas-devel bzip2 python-opengl

wget "https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh" -O "conda.sh"

sh conda.sh

source ~/.bashrc
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
conda config --set show_channel_urls yes
sed -i "s/- defaults/# - defaults/g" ~/.condarc
conda config --add channels conda-forge
conda update --yes -n base conda
conda update --all --yes
#    /conda/bin/conda create -n tf20 python=3.7.3 && \
#    echo "source activate sup" >> ~/.bashrc && \
conda install tensorflow-gpu
