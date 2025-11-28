# Base Image: Ubuntu 22.04 LTS
FROM ubuntu:22.04

# Prevent interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# 1. Update and Install Core System Tools & C/C++ Compilers
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
    && rm -rf /var/lib/apt/lists/*

# 2. Install Python 3, Pip, and Science Dependencies
# CHANGED: Added 'gfortran libopenblas-dev' so scipy/numpy compile correctly.
# REMOVED: '--break-system-packages' (not needed/supported on Ubuntu 22.04)
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-venv python3-dev \
    gfortran libopenblas-dev liblapack-dev pkg-config \
    && pip3 install --no-cache-dir \
    numpy pandas requests flask django fastapi uvicorn scipy matplotlib beautifulsoup4

# 3. Install Java (OpenJDK 17)
RUN apt-get update && apt-get install -y openjdk-17-jdk

# 4. Install Node.js (Version 20.x LTS)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# 5. Install Docker CLI
# We install the CLI so you can type 'docker ps' inside the terminal.
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update && apt-get install -y docker-ce-cli

# 6. Install TTYD (The Web-Shell Bridge)
RUN curl -L https://github.com/tsl0922/ttyd/releases/download/1.7.4/ttyd.x86_64 -o /usr/bin/ttyd \
    && chmod +x /usr/bin/ttyd

# 7. Configuration
ENV SHELL=/bin/bash
ENV TERM=xterm-256color
WORKDIR /root

# Expose the terminal port
EXPOSE 7681

# Start TTYD
# -W enables writing, -b / sets base path
CMD ["ttyd", "-W", "bash"]
