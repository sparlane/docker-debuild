# Dockerfile for building Debian packages using current stable repo.
FROM debian:buster

RUN apt update && apt install -y ca-certificates curl gnupg

RUN curl https://apt.canterburyairpatrol.org/repository.key | apt-key add -

COPY sources-list /etc/apt/sources.list
RUN apt-get update && apt-get install -y --no-install-recommends \
  devscripts \
  equivs \
  rsync \
  locales \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

VOLUME /package

COPY packagebuild /usr/local/bin/
COPY devscripts /root/.devscripts

RUN chmod 755 /usr/local/bin/packagebuild
ENTRYPOINT ["packagebuild"]
