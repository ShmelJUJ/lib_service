# syntax=docker/dockerfile:1

FROM python:3.12.2-alpine3.19
WORKDIR /app

COPY requirement.txt requirement.txt
RUN \
 apk add --no-cache postgresql-libs && \
 apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev && \
 python3 -m pip install -r requirement.txt --no-cache-dir && \
 apk --purge del .build-deps

COPY . .





