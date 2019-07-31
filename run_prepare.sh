yum -y install epel-release
sudo yum -y update

sudo yum clean all
sudo yum list #避免更换源后出现HTTP ERORR 404-Not Found 报错
sudo yum makecache #将服务器上的软件包信息在本地缓存,以提高搜索安装软件的速度。

sudo yum -y update

sudo yum install -y curl git wget htop xorg-x11-xauth.x86_64 htop xorg-x11-apps.x86_64

# for local conda
yum -y install gcc gcc-c++ gcc-gfortran openssl-devel libffi-devel python-pip python-devel atlas atlas-devel bzip2 python-opengl

# install docker
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce
sudo usermod -aG docker $(whoami)
sudo systemctl enable docker.service
sudo systemctl start docker.service

# x11
sudo sed -i 's/#X11DisplayOffset 10/X11DisplayOffset 10/g' /etc/ssh/sshd_config 
echo "export DISPLAY='127.0.0.1:10.0'" >> ~/.bashrc
export DISPLAY='127.0.0.1:10.0'
source ~/.bashrc

# test
sudo grep X11 /etc/ssh/sshd_config
xclock
sudo docker run hello-world
