FROM ubuntu:24.04

WORKDIR /opt

RUN apt update -y && \
    apt upgrade -y && \
    apt install wget -y

RUN mkdir -m 775 -p /root/.minio/certs/ && \
    cd /root/.minio/certs/ && \
    wget https://github.com/minio/certgen/releases/latest/download/certgen-linux-amd64 && \
    chmod 755 certgen-linux-amd64 && \
    ./certgen-linux-amd64 -host "127.0.0.1,localhost"

RUN wget https://dl.min.io/server/minio/release/linux-amd64/archive/minio_20241029160148.0.0_amd64.deb -O minio.deb && \
    dpkg -i minio.deb

RUN mkdir -p ~/minio

VOLUME ["/data"]

CMD ["minio", "server", "/root/minio", "--console-address", ":9001"]
