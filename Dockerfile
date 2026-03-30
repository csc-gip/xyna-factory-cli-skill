FROM docker.io/library/node:latest

ENV DEBIAN_FRONTEND=noninteractive

# Install required CLI tools and helpers.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        libxml2-utils \
        ripgrep \
        openssh-client \
    && rm -rf /var/lib/apt/lists/*

# Create user "pi".
RUN useradd -m -s /bin/bash pi

# Install PI coding agent globally.
RUN npm install -g @mariozechner/pi-coding-agent

# Install this skill for user "pi".
RUN mkdir -p /home/pi/.agents/skills/xyna-factory-cli
COPY xyna-factory-cli/ /home/pi/.agents/skills/xyna-factory-cli/
RUN chown -R pi:pi /home/pi/.agents

USER pi
WORKDIR /home/pi

CMD ["bash"]
