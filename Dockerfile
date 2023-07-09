FROM python:3.10-slim
USER root

RUN apt-get -y update
#RUN apt-get -y install gcc

COPY src /app
COPY requirements.txt /app
COPY docker-entrypoint.sh /app
RUN chmod +x /app/docker-entrypoint.sh

WORKDIR /app

RUN python -m pip install -r requirements.txt

RUN useradd pyuser -g root
USER pyuser

ENV DEBUG=true

EXPOSE 8000

ENTRYPOINT ["/app/docker-entrypoint.sh"]
