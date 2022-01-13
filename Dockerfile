FROM centos:8

USER root

COPY contrib/entrypoint.sh /

RUN dnf install -y          \
  nss_wrapper               \
  gettext                   \
  postgresql                \
  bind-utils                \
  vim                     &&\
  chmod +x /entrypoint.sh &&\
  chmod g+w /etc/passwd

ENTRYPOINT ["/entrypoint.sh"]
