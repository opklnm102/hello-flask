FROM python:3.8.8-slim-buster AS builder

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      build-essential \
      gcc \
 && rm -rf /var/lib/apt/lists/*

COPY Pipfile* ./
RUN python -m pip install pipenv \
    && python -m pipenv install --system --deploy --ignore-pipfile

FROM python:3.8.8-slim-buster

RUN useradd --create-home app
WORKDIR /home/app
USER app

COPY --from=builder /usr/local/lib/python3.8/site-packages /usr/local/lib/python3.8/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin
COPY --chown=app:app . .

EXPOSE 5000 9091

CMD ["uwsgi", "hello-flask.ini"]

ENTRYPOINT ["./docker-entrypoint"]
