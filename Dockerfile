FROM alpine:3.22

ENV CGIT_VER="1.2.3-r5"
ENV LIGHTTPD_VER="1.4.79-r0"

LABEL description="A hyperfast web frontend for git repositories written in C" \
      name="cgit"

# Install cgit and lighttpd
RUN apk add --no-cache \
    highlight=4.13-r0 \
    lighttpd=${LIGHTTPD_VER} \
    cgit=${CGIT_VER}

RUN mkdir -p /srv/projects/

# lighttpd config
COPY rootfs/files/lighttpd.cgit.conf      /etc/lighttpd/

# cgit files
COPY rootfs/files/syntax-highlighting.sh  /usr/lib/cgit/filters/
COPY rootfs/files/repo.list               /srv/
COPY rootfs/files/cgitrc                  /etc/

# Expose port 80
EXPOSE 80

# Start lighttpd
CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.cgit.conf"]
