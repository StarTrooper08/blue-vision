# -------------------------------------------------
# BlueVision DevContainer
# -------------------------------------------------

FROM mcr.microsoft.com/devcontainers/base:ubuntu

# -------------------------------------------------
# Install system dependencies
# -------------------------------------------------

RUN apt-get update && \
    apt-get install -y \
        curl \
        wget \
        tar \
        git \
        gnupg \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# -------------------------------------------------
# Copy Copilot install script
# -------------------------------------------------

COPY scripts/install-copilot.sh /tmp/install-copilot.sh
RUN chmod +x /tmp/install-copilot.sh

# Optional: pin version
ENV VERSION=latest

# Install GitHub Copilot CLI
RUN /tmp/install-copilot.sh

# Cleanup
RUN rm /tmp/install-copilot.sh

# Verify installation
RUN copilot --version


# Install Github CLI
# Install GitHub CLI
RUN mkdir -p -m 755 /etc/apt/keyrings && \
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
      | gpg --dearmor -o /etc/apt/keyrings/githubcli-archive-keyring.gpg && \
    chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
      > /etc/apt/sources.list.d/github-cli.list && \
    apt-get update && \
    apt-get install -y gh && \
    rm -rf /var/lib/apt/lists/*



# -------------------------------------------------
# Install BlueVision CLI
# -------------------------------------------------

COPY bluevision.sh /usr/local/bin/bluevision
RUN chmod +x /usr/local/bin/bluevision

COPY lib /usr/local/bin/lib
COPY commands /usr/local/bin/commands

# -------------------------------------------------
# Install bv wrapper (shortcut)
# -------------------------------------------------

COPY scripts/bv.sh /usr/local/bin/bv
RUN chmod +x /usr/local/bin/bv

# -------------------------------------------------
# Install Welcome Script
# -------------------------------------------------

COPY scripts/welcome.sh /usr/local/bin/welcome
RUN chmod +x /usr/local/bin/welcome




# Show welcome only in interactive terminal
RUN echo 'if [ -t 1 ]; then welcome; fi' >> /home/vscode/.bashrc


# Default shell


CMD ["/bin/bash"]
