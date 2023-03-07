FROM python:3.8-alpine

LABEL "com.github.actions.name"="S3 Head Object"
LABEL "com.github.actions.description"="Head object in AWS S3"
LABEL "com.github.actions.icon"="refresh-cw"
LABEL "com.github.actions.color"="green"

ENV AWSCLI_VERSION='1.18.14'

RUN apk add jq
RUN pip install --quiet --no-cache-dir awscli==${AWSCLI_VERSION}

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]