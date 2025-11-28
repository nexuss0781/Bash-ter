# Use the latest Ubuntu LTS as the base system
FROM ubuntu:22.04

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# 1. Install standard Linux tools to make it a "Full Environment"
# We include editors, network tools, process monitors, and build essentials.
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
    build-essential \
    python3 \
    python3-pip \
    sudo \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# 2. Install TTYD (The Real-Terminal-Over-Web Bridge)
# We fetch the binary directly to avoid long compilation times.
RUN curl -L https://github.com/tsl0922/ttyd/releases/download/1.7.4/ttyd.x86_64 -o /usr/bin/ttyd \
    && chmod +x /usr/bin/ttyd

# 3. Setup the Shell Environment
# Set the shell to bash and enable color support
ENV SHELL=/bin/bash
ENV TERM=xterm-256color

# 4. Create a workspace directory
WORKDIR /root

# 5. Expose the port used by the web terminal
EXPOSE 7681

# 6. Start TTYD and bind it to bash
# -W: check for window resize
# bash: the actual process to run
CMD ["ttyd", "-W", "bash"]
