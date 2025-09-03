FROM alpine:3.22 AS tmp

RUN --mount=type=cache,target=/var/cache/apk \
    apk add curl unzip

ENV VERSION=8.1.31
RUN curl -sSL https://github.com/lensesio/stream-reactor/releases/download/${VERSION}/kafka-connect-aws-s3-${VERSION}.zip -o /tmp/kafka-connect-aws-s3.zip
RUN unzip -d /tmp /tmp/kafka-connect-aws-s3.zip
RUN mkdir -p /opt/lib
RUN cp /tmp/kafka-connect-aws-s3-${VERSION}/kafka-connect-aws-s3-assembly-${VERSION}.jar /opt/lib/

FROM alpine:3.22
COPY --from=tmp /opt/lib /opt/lib
