FROM mongo:6.0.5

ENV KEYFILE /opt/mongo/keyfile

RUN mkdir -p /opt/mongo
RUN openssl rand -base64 756 > $KEYFILE
RUN chown -R mongodb /opt/mongo
RUN chmod 400 $KEYFILE

COPY ./init-replicaset.js /docker-entrypoint-initdb.d/init-replicaset.js

ENTRYPOINT docker-entrypoint.sh --keyFile $KEYFILE --replSet rs0 & tail -f /dev/null