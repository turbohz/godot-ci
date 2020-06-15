FROM ubuntu:focal
LABEL author="artur@barichello.me"

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
    python \
    python-openssl \
    unzip \
    wget \
    zip \
    && rm -rf /var/lib/apt/lists/*

ENV GODOT_VERSION "3.2.2"
ENV GODOT_BRANCH "beta4"
# HEADSUP! "stable" branch does not have the branch name (stable) as part of the URL
ENV GODOT_URL "https://downloads.tuxfamily.org/godotengine/3.2.2/beta4"

RUN wget ${GODOT_URL}/Godot_v${GODOT_VERSION}-${GODOT_BRANCH}_linux_headless.64.zip \
    && wget ${GODOT_URL}/Godot_v${GODOT_VERSION}-${GODOT_BRANCH}_export_templates.tpz \
    && mkdir ~/.cache \
    && mkdir -p ~/.config/godot \
    && mkdir -p ~/.local/share/godot/templates/${GODOT_VERSION}.${GODOT_BRANCH} \
    && unzip Godot_v${GODOT_VERSION}-${GODOT_BRANCH}_linux_headless.64.zip \
    && mv Godot_v${GODOT_VERSION}-${GODOT_BRANCH}_linux_headless.64 /usr/local/bin/godot \
    && unzip Godot_v${GODOT_VERSION}-${GODOT_BRANCH}_export_templates.tpz \
    && mv templates/* ~/.local/share/godot/templates/${GODOT_VERSION}.${GODOT_BRANCH} \
    && rm -f Godot_v${GODOT_VERSION}-${GODOT_BRANCH}_export_templates.tpz Godot_v${GODOT_VERSION}-${GODOT_BRANCH}_linux_headless.64.zip

ADD getbutler.sh /opt/butler/getbutler.sh
RUN bash /opt/butler/getbutler.sh
RUN /opt/butler/bin/butler -V

ENV PATH="/opt/butler/bin:${PATH}"
