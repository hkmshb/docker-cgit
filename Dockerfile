FROM alpine:3.20.2

# Install cgit and lighttpd
RUN apk add --no-cache \
    highlight \
    lighttpd \
    cgit

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
