FROM python:3.10-slim
USER root

RUN apt-get -y update
RUN apt-get -y install gcc

COPY src /app
COPY requirements.txt /app
COPY docker-entrypoint.sh /app
RUN chmod +x /app/docker-entrypoint.sh

WORKDIR /app

RUN python -m pip install -r requirements.txt

ARG user=pyuser
ARG group=pyuser
ARG uid=1001
ARG gid=1001
RUN groupadd -g ${gid} ${group}
RUN useradd -u ${uid} -g ${group} -s /bin/sh -m ${user} # <--- the '-m' create a user home directory

RUN chown ${uid}:${gid} -R /app

# Switch to user
USER ${uid}:${gid}

ENV DEBUG=true

EXPOSE 8000

ENTRYPOINT ["/app/docker-entrypoint.sh"]
