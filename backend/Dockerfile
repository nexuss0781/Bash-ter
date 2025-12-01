# Base Image: Ubuntu 22.04 LTS
FROM ubuntu:22.04

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# ---------------------------------------------------------------------
# 1. Install Core System Tools, Java, Gradle, & Python Alias
# ---------------------------------------------------------------------
# Added 'gradle' and 'python-is-python3' (allows typing 'python')
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
    zip \
    sudo \
    build-essential \
    software-properties-common \
    ca-certificates \
    gnupg \
    lsb-release \
    # Compilers & Math Libs
    gfortran \
    libopenblas-dev \
    liblapack-dev \
    pkg-config \
    # JAVA & GRADLE
    openjdk-17-jdk \
    gradle \
    # PYTHON COMPATIBILITY (Makes 'python' command work)
    python-is-python3 \
    && rm -rf /var/lib/apt/lists/*

# ---------------------------------------------------------------------
# 2. Install Android SDK (Command Line Tools)
# ---------------------------------------------------------------------
ENV ANDROID_HOME /opt/android-sdk
ENV PATH ${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools

# Download and arrange files specifically how 'sdkmanager' expects them
# (cmdline-tools/latest/bin/sdkmanager)
RUN mkdir -p ${ANDROID_HOME}/cmdline-tools \
    && wget -q https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip -O android_tools.zip \
    && unzip -q android_tools.zip -d ${ANDROID_HOME}/cmdline-tools \
    && mv ${ANDROID_HOME}/cmdline-tools/cmdline-tools ${ANDROID_HOME}/cmdline-tools/latest \
    && rm android_tools.zip

# Accept Licenses and Install Platform Tools
RUN yes | sdkmanager --licenses \
    && sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.2"

# ---------------------------------------------------------------------
# 3. Install Python 3 Libraries
# ---------------------------------------------------------------------
RUN apt-get update && apt-get install -y \
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
# 4. Install Node.js (Latest LTS - v20.x)
# ---------------------------------------------------------------------
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# ---------------------------------------------------------------------
# 5. Install Docker CLI
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

# Start TTYD
CMD ["ttyd", "-W", "bash"]
