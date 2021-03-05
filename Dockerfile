# Build Debian 9 (Stretch) image.

FROM debian:9
LABEL maintainer="François KUBLER"

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    python-pip \
    systemd \
 && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade setuptools \
 && pip install wheel \
 && pip install ansible \
 && pip install molecule-docker

# RUN mkdir -p /etc/ansible \
#  && echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

RUN mkdir -p /etc/ansible
ADD hosts /etc/ansible/

ENV ANSIBLE_FORCE_COLOR 1

ENTRYPOINT ["/lib/systemd/systemd"]
