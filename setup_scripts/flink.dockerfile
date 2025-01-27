# from https://github.com/wealthsimple/postgres-cdc/blob/86024e8629d7c362d6c3f08f71982bfe717abdf7/docker/flink/flink.dockerfile

# split downloads so the layers are cached independently, and the .tar.gzs aren't included in the final image (reducing the size)
# https://medium.com/@tonistiigi/advanced-multi-stage-build-patterns-6f741b852fae

FROM flink:1.18.1-scala_2.12-java17

WORKDIR /opt/flink

# Web UI
EXPOSE 8081
