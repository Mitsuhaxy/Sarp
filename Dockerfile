FROM ubuntu
LABEL maintainer="sarp"

COPY ./entrypoint.sh /entrypoint.sh
RUN apt-get update \
    && apt-get install iptables iproute2 shadowsocks-libev wireguard net-tools openresolv -y \
    && chmod +x /entrypoint.sh

EXPOSE 8388
EXPOSE 8388/udp
ENV TZ=Asia/Shanghai
ENV key=password
ENV dns=1.1.1.1
ENV method=aes-256-gcm
ENTRYPOINT "/entrypoint.sh"
