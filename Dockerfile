FROM centos:8

USER root

COPY contrib/entrypoint.sh /
RUN dnf install -y  \
  postgresql        \
  bind-utils        \
  vim               &&\
  chmod +x /entrypoint.sh


ENTRYPOINT ["/entrypoint.sh"]


