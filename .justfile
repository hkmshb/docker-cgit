export VER := "1.2.3.2-alpine3.22"

default:
  just -l

build:
  docker build --no-cache -t hkmshb/cgit:${VER} .

push:
  docker push hkmshb/cgit:${VER}

run:
  docker run --rm --name cgit \
         --publish $CGIT_PORT:80 \
         --volume $PROJECT_DIR:/projects \
         hkmshb/cgit:${VER}
