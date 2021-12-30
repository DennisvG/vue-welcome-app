# build stage app
FROM node:lts-alpine as build-stage
WORKDIR /app
# Copy proxy settingss for npm
# COPY $WORKSPACE/.npmrc .npmrc
COPY $WORKSPACE/package.json ./
RUN npm install -g @vue/cli
RUN npm install
COPY . .
RUN npm run build
# Remove proxy settingss for npm
# RUN rm -f .npmrc

# build extra nginx modules
FROM nginx:stable-alpine as build-nginx
ENV MORE_HEADERS_VERSION=0.33
ENV MORE_HEADERS_GITREPO=openresty/headers-more-nginx-module
#ENV http_proxy="http://proxy.prd.duo.nl:8080"
#ENV https_proxy="http://proxy.prd.duo.nl:8080"

# fix for wget error in combination with proxy
RUN apk --no-cache add openssl wget

# Download sources
RUN wget "http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz" -O nginx.tar.gz && \
    wget "https://github.com/${MORE_HEADERS_GITREPO}/archive/v${MORE_HEADERS_VERSION}.tar.gz" -O extra_module.tar.gz

# For latest build deps, see https://github.com/nginxinc/docker-nginx/blob/master/mainline/alpine/Dockerfile
RUN  apk add --no-cache --virtual .build-deps \
    gcc \
    libc-dev \
    make \
    openssl-dev \
    pcre-dev \
    zlib-dev \
    linux-headers \
    libxslt-dev \
    gd-dev \
    geoip-dev \
    perl-dev \
    libedit-dev \
    mercurial \
    bash \
    alpine-sdk \
    findutils

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

RUN rm -rf /usr/src/nginx /usr/src/extra_module && mkdir -p /usr/src/nginx /usr/src/extra_module && \
    tar -zxC /usr/src/nginx -f nginx.tar.gz && \
    tar -xzC /usr/src/extra_module -f extra_module.tar.gz

WORKDIR /usr/src/nginx/nginx-${NGINX_VERSION}

# Reuse same cli arguments as the nginx:alpine image used to build
RUN CONFARGS=$(nginx -V 2>&1 | sed -n -e 's/^.*arguments: //p') && \
    sh -c "./configure --with-compat $CONFARGS --add-dynamic-module=/usr/src/extra_module/*" && make modules

# production stage
FROM nginx:stable-alpine as production-stage
# install extra module
COPY --from=build-nginx /usr/src/nginx/nginx-${NGINX_VERSION}/objs/*_module.so /etc/nginx/modules/
# support running as arbitrary user which belogs to the root group
RUN chmod g+rwx /var/cache/nginx /var/run /var/log/nginx
# users are not allowed to listen on priviliged ports
RUN sed -i.bak 's/listen\(.*\)80;/listen 8080;/' /etc/nginx/conf.d/default.conf
EXPOSE 8080
# Add new nginx.conf to /etc/nginx/nginx.conf
ADD $WORKSPACE/nginx/nginx.conf /etc/nginx/
COPY --from=build-stage /app/dist /usr/share/nginx/html