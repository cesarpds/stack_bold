docker build -t minio_image .
docker run -d -p 9000:9000 -p 9001:9001  minio_image
