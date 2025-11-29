# Base Image: Ubuntu 22.04 LTS
FROM ubuntu:22.04

# Prevent interactive prompts (timezone selection, etc.)
ENV DEBIAN_FRONTEND=noninteractive

# ---------------------------------------------------------------------
# 1. Install Core System Tools & Build Essentials
# ---------------------------------------------------------------------
RUN apt-get update && apt-get install -y \
    bash \
    vim \
    nano \
    git \
    curl \
    wget \
    htop \
    tmux \
    net-tools \
    iputils-ping \
    unzip \
    sudo \
    build-essential \
    software-properties-common \
    ca-certificates \
    gnupg \
    lsb-release \
    # Libraries required for Python Scipy/Numpy compilation
    gfortran \
    libopenblas-dev \
    liblapack-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# ---------------------------------------------------------------------
# 2. Install Python 3 & Data Science/Web Packages
# ---------------------------------------------------------------------
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    && pip3 install --no-cache-dir \
    numpy \
    pandas \
    requests \
    flask \
    django \
    fastapi \
    uvicorn \
    scipy \
    matplotlib \
    beautifulsoup4

# ---------------------------------------------------------------------
# 3. Install Java (OpenJDK 17)
# ---------------------------------------------------------------------
RUN apt-get update && apt-get install -y openjdk-17-jdk

# ---------------------------------------------------------------------
# 4. Install Node.js (Latest LTS - v20.x)
# ---------------------------------------------------------------------
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# ---------------------------------------------------------------------
# 5. Install Docker CLI
# (Allows usage of 'docker ps' inside the container via socket mounting)
# ---------------------------------------------------------------------
RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update && apt-get install -y docker-ce-cli

# ---------------------------------------------------------------------
# 6. Install TTYD (Web-to-Shell Bridge)
# ---------------------------------------------------------------------
RUN curl -L https://github.com/tsl0922/ttyd/releases/download/1.7.4/ttyd.x86_64 -o /usr/bin/ttyd \
    && chmod +x /usr/bin/ttyd

# ---------------------------------------------------------------------
# 7. Final Configuration
# ---------------------------------------------------------------------
ENV SHELL=/bin/bash
ENV TERM=xterm-256color
WORKDIR /root

# Expose the WebSocket port
EXPOSE 7681

# Start TTYD allowing write access (-W) and binding to bash
CMD ["ttyd", "-W", "bash"]
