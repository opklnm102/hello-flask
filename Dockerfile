FROM python:3.8.8-slim-buster

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      build-essential \
      gcc \
 && rm -rf /var/lib/apt/lists/*

COPY ./requirements.txt ./
RUN pip install -r requirements.txt

RUN useradd --create-home app
WORKDIR /home/app
USER app

COPY --chown=app:app . .

EXPOSE 5000 9091

CMD ["uwsgi", "hello-flask.ini"]

ENTRYPOINT ["./docker-entrypoint"]
