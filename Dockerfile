FROM registry.access.redhat.com/ubi8/ubi-minimal:latest

USER root

COPY contrib/entrypoint.sh /

# Seems broken in latest ubi, cant install due to
# perl 5.24 requirement.
# automake            \
# libtool             \

ARG pkgs="            \
  bind-utils          \
  cmake               \
  cyrus-sasl-devel    \
  gcc                 \
  gcc-c++             \
  gettext             \
  git                 \
  glibc-devel         \
  iproute             \
  iputils             \
  java-1.8.0-openjdk  \
  jq                  \
  libcurl-devel       \
  libzstd             \
  nss_wrapper         \
  openssl-devel       \
  postgresql          \
  python2             \
  python3             \
  socat               \
  tar                 \
  vim                 \
  wget                \
  zlib                \
"

# Main packages
ARG url_pg="https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm"
RUN                             \
  rpm -Uvh ${url_pg}          &&\
  microdnf install -y ${pkgs} &&\
  chmod +x /entrypoint.sh     &&\
  chmod g+w /etc/passwd


# Install kcat
ARG url_libzstd_dev="http://ftp.usf.edu/pub/centos/8-stream/BaseOS/x86_64/os/Packages/libzstd-devel-1.4.4-1.el8.x86_64.rpm"
RUN                                                 \
  rpm -Uvh ${url_libzstd_dev}                     &&\
  git clone https://github.com/edenhill/kcat.git  &&\
  cd kcat                                         &&\
  ./bootstrap.sh                                  &&\
  cp -av kcat /usr/local/bin/                     &&\
  rm -rf /kcat*


# Install kafka-related scripts
arg url_kafka="https://archive.apache.org/dist/kafka/3.1.0/kafka_2.13-3.1.0.tgz"
RUN \
  curl ${url_kafka} --output kafka.tgz  &&\
  tar zxvfp kafka.tgz                   &&\
  cd kafka_2.13-3.1.0                   &&\
  cp -arv config/ libs/ /usr/local/     &&\
  cp -v bin/*.sh /usr/local/bin/        &&\
  rm -rf /kafka*


# Install casssandra
ARG url_cassandra="https://archive.apache.org/dist/cassandra/redhat/311x/cassandra-3.11.12-1.noarch.rpm"
RUN \
  rpm -Uvh ${url_cassandra}   &&\
  pip3 install six cqlsh      &&\
  rm -f /usr/local/bin/cqlsh

ENTRYPOINT ["/entrypoint.sh"]
