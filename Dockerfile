FROM registry.access.redhat.com/ubi8/ubi-minimal:latest

USER root

COPY contrib/entrypoint.sh /

ARG pkgs="bind-utils  \
          gettext     \
          nss_wrapper \
          postgresql  \
          python2     \
          socat       \
          tar         \
          vim"

ARG url_pg="https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm"
ARG url_kcat="https://download.copr.fedorainfracloud.org/results/bvn13/kcat/mageia-8-x86_64/04222553-kcat/kcat-1.7.0-1.mga8.x86_64.rpm"
ARG url_kcat_dep="https://rpmfind.net/linux/centos/8-stream/AppStream/x86_64/os/Packages/librdkafka-0.11.4-1.el8.x86_64.rpm"

RUN                                         \
  curl -o /tmp/kcat.rpm ${url_kcat}         &&\
  curl -o /tmp/kcat_dep.rpm ${url_kcat_dep} &&\
  curl -o /tmp/pg.rpm ${url_pg}             &&\
  rpm -Uvh /tmp/pg.rpm    \
           /tmp/kcat.rpm  \
           /tmp/kcat_dep.rpm                &&\
  microdnf install -y ${pkgs}               &&\
  chmod +x /entrypoint.sh                   &&\
  chmod g+w /etc/passwd

# RUN dnf install -y https://downloads.apache.org/cassandra/redhat/311x/cassandra-3.11.11-1.noarch.rpm &&\
# rm -f /usr/share/cassandra/lib/six-1.7.3-py2.py3-none-any.zip
# pip2 install six cqlsh

ENTRYPOINT ["/entrypoint.sh"]
