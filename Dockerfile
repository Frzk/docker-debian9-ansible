# Build Debian 9 (Stretch) image.

FROM debian:9

LABEL maintainer="François KUBLER"

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  build-essential \
  systemd \
  python-pip \
  git

RUN apt-get clean

RUN pip install --upgrade setuptools && pip install wheel && pip install ansible

RUN mkdir -p /etc/ansible && echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

ENTRYPOINT ["/bin/systemd"]
