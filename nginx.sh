mkdir -p /usr/local/dockercerts

#nginx template
curl https://raw.githubusercontent.com/lantrix/nginx-proxy/master/nginx.tmpl > /usr/local/nginx.tmpl

#Setup nginx
docker run -d \
  -p 80:80 -p 443:443 \
  --name nginx \
  -v /etc/nginx/conf.d  \
  -v /etc/nginx/vhost.d \
  -v /usr/share/nginx/html \
  -v /usr/local/dockercerts:/etc/nginx/certs:ro \
  -e "VIRTUAL_PORT=8888" \
  nginx

#Generate nginx template
docker run -d \
  --name nginx-gen \
  --volumes-from nginx \
  -v /usr/local/nginx.tmpl:/etc/docker-gen/templates/nginx.tmpl:ro \
  -v /var/run/docker.sock:/tmp/docker.sock:ro \
  lantrix/docker-gen \
  -notify-sighup nginx -watch -wait 5s:30s /etc/docker-gen/templates/nginx.tmpl /etc/nginx/conf.d/default.conf

# Gen/Renew certs https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion
docker run -d \
  --name nginx-letsencrypt \
  --volumes-from nginx \
  -v /usr/local/dockercerts:/etc/nginx/certs:rw \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  -e NGINX_DOCKER_GEN_CONTAINER=nginx-gen \
  -e NGINX_PROXY_CONTAINER=nginx \
  lantrix/letsencrypt-nginx-proxy-companion

#config domain
export DOMAIN="your.domain"

#start searx
docker run -d \
  --expose 8888 \
  -e "VIRTUAL_HOST=searx.${DOMAIN}" \
  -e "LETSENCRYPT_HOST=searx.${DOMAIN}" \
  -e "LETSENCRYPT_EMAIL=webmaster@${DOMAIN}" \
  --name searx \
  -t lantrix/searx