# Build Debian 9 (Stretch) image.

FROM debian:9
LABEL maintainer="François KUBLER"

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    libssl-dev \
    python3-pip \
    systemd \
 && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --upgrade pip \
 && python3 -m pip install --upgrade setuptools \
 && python3 -m pip install wheel ansible molecule[docker,lint]

# RUN mkdir -p /etc/ansible \
#  && echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

RUN mkdir -p /etc/ansible
ADD hosts /etc/ansible/

ENV ANSIBLE_FORCE_COLOR 1

ENTRYPOINT ["/lib/systemd/systemd"]
