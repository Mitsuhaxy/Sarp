FROM alpine
LABEL maintainer="sarp"

COPY ./entrypoint.sh /entrypoint.sh
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && apk update \
    && apk add -y iptables iproute2 shadowsocks-libev wireguard-tools net-tools openresolv \
    && chmod +x /entrypoint.sh

EXPOSE 8388
EXPOSE 8388/udp
ENV TZ=Asia/Shanghai
ENV key=password
ENV dns=1.1.1.1
ENV method=aes-256-gcm
ENTRYPOINT "/entrypoint.sh"
