# OTG Stack

Run your own services, control your own data.

This is code for deploying your own docker based apps on a host in some datacentre.

## Pre-requisites

Meant for Ubuntu 18.04 LTS

## Install

 * Edit `.env` and populate environment variables.
 * From the root of this cloned repo run `./provision/docker.sh` to install docker
 * From the root of this cloned repo run `./provision/otg-stack.sh` to setup and start the docker-compose daemon

## Services

### Search Engine

Using the hackable [search sngine Searx](https://github.com/lantrix/searx), you will have a stateless, non-logging search engine of your own.
