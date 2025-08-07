export VER := "1.2.3-alpine3.22"

default:
  just -l

build:
  docker build --no-cache -t hkmshb/cgit:${VER} .

run:
  docker run --rm --name cgit \
         --publish $CGIT_PORT:80 \
         --volume $PROJECT_DIR:/srv/projects \
         hkmshb/cgit:${VER}
