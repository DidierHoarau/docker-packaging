# docker-packaging
Basic set of tool to run and build your application in Docker

Once you run applications in Docker cobtainers, you will want to standardize and automate the way your applications are deployed.

This repository is meant to be added to applications repositories as a submodules to provide standardized scripts to deploy in Docker and Docker swarm. The idea is to have a set of common command that are set in all applications so that your CI/CD tools can fall the same set of commands for all projects.

The typical workflow is as follow:

- Prepare: you may generate application files during this step
- Image Build: Build the Docker image
- Run/Deploy
  - Without Docker Swarm: Service Run
  - With Docker Swarm: Service Deploy

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
"packaging:service-run": "docker-packaging/service-run.sh"
```

Note: Your package.json file can obviously contain other elements and other script but it should at least contain the one above.

### Creating the docker-packaging-config folder

You must then create a docker-packaging-config folder. This folder will contain your Docker definitions and your custon building scripts. (This will be explained in the next 2 parts)

### Creating the Docker Compose files

The docker-packaging-config folder must contain a docker-compose.yml.

This standard docker-compose file will contain the definition of your app.

Optionally you can define a docker-compose.deploy.yml file. You might do so if the parameters set in the main docker-compose file is not the one to take into account durring deployment.


### Creating custom scripts

The docker-packaging-config folder can optionally contain the following files:
- prepare.sh:
- service-deploy-before.sh
- service-deploy-after.sh
- service-run-before.sh
- service-run-after.sh

## Use

Once you have integrated this building module in your projects, you can deploy any or them with the same sequence of command::
- Without Docker Swarm:
  - npm run packaging:prepare
  - npm run packaging:image-build
  - npm run packaging:service-run
- With Docker Swarm:
  - npm run packaging:prepare
  - npm run packaging:image-build
  - npm run packaging:service-deploy
