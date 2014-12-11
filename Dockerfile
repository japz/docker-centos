FROM centos:latest

ADD files /build

RUN /build/build.sh \
    && rm -rf /build

ENTRYPOINT ["/scripts/entrypoint.sh"]
CMD ["/usr/bin/supervisord"]

