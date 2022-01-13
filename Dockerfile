FROM centos:8

USER root

RUN dnf install -y \
  postgresql       \
  bind-utils       \
  vim

ENTRYPOINT ["/bin/bash", "-c", "sleep 999999999"]


