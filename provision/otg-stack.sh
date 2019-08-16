#!/bin/bash
set -euxo pipefail
cat .env >> ~/.bashrc
. .env
curl -s https://raw.githubusercontent.com/lantrix/nginx-proxy/master/nginx.tmpl > /usr/local/nginx.tmpl
docker-compose up -d
