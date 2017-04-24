# docker-packaging
Basic set of tool to run and build your application in Docker

Once you run applications in Docker cobtainers, you will want to standardize and automate the way your applications are deployed.

This repository is meant to be added to applications repositories as a submodules to provide standardized scripts to deploy in Docker and Docker swarm.

## Prerequesites

The scripts require the following:
- Docker 1.13 or above
- At the time of writting, you need to enable experimental features in Docker
- Docker Compose

Those script are only tested on Linux Bash.

## Adding submodule

From the git command line or your git UI of choice, you have to add this repository as submodule.

### Setting up the package.json

Your project (the parent folder) must have a package.json file. This file must contain at least the following element:
- name
- version
- the following script lines:
```
"packaging:prepare": "docker-packaging/prepare.sh",
"packaging:image-build": "docker-packaging/image-build.sh",
"packaging:service-deploy": "docker-packaging/service-deploy.sh",
"packaging:container-run": "docker-packaging/container-run.sh"
```

Note: Your package.json file can obviously contain other elements and other script but it should at least contain the one above.

### Creating the docker-packaging-config folder

You must then create a docker-packaging-config folder. This folder will contain your Docker definitions and your custon building scripts.

### Creating the Docker Compose files

### Creating custom scripts