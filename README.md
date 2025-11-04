# docker-cgit

A Docker image for cGit, a lightweight web interface for git, running over Lighttpd.

## Installation

Download this image from Docker hub

```
docker pull hkmshb/cgit
```

## Usage

To launch a container from this image, run:

```
docker run -d --rm \
       --name cgit \
       -p 2340:80 \
       -v <host-path>:/projects \
       hkmshb/cgit
```

