FROM ubuntu:16.04

# Set environment variables.
ENV HOME /root
ENV PIP_FORMAT=columns
ENV TZ='Europe/Berlin'
ENV DEBIAN_FRONTEND=noninteractive
ENV PS1='\[\033[31m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]$(__git_ps1 "(%s)")\$ '

# Install.
# echo "PS1='\[\033[31m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]$(__git_ps1 "(%s)")\$ '" | tee -a ~/.bashrc && \
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  sed -i -e 's/http:\/\/security/mirror:\/\/mirrors/' -e 's/http:\/\/archive/mirror:\/\/mirrors/' -e 's/\/ubuntu\//\/mirrors.txt/' /etc/apt/sources.list && \
  apt update && \
  apt install -y apt-utils && \
  apt upgrade -y && \
  apt install -y \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    build-essential \
    python \
    python-virtualenv \
    python-pip \
    python3 \
    python3-virtualenv \
    python3-pip \
    git \
    curl \
    nmap \
    vim-nox && \
  git config --global pull.rebase true && \
  git config --global user.name "cblaupanda" && \
  git config --global user.email "christoph.blau@foodora.com" && \
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
  add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable" && \
  apt-get update && apt-get -y install docker-ce && \
  rm -rf /var/lib/apt/lists/*

# Add files.
ADD bashrc /root/.bashrc
#ADD root/.gitconfig /root/.gitconfig
#ADD root/.scripts /root/.scripts

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]
