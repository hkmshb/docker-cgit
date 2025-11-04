export VER := "1.2.3.1-alpine3.22"

default:
  just -l

build:
  docker build --no-cache -t hkmshb/cgit:${VER} .

# --volume $(PWD)/rootfs/files/gfm.css:/usr/share/webapps/cgit/gfm.css \
# --volume $(PWD)/rootfs/files/source-formatting.sh:/usr/lib/cgit/filters/source-formatting.sh \
run:
  docker run --rm --name cgit \
         --publish $CGIT_PORT:80 \
         --volume $PROJECT_DIR:/projects \
         hkmshb/cgit:${VER}
