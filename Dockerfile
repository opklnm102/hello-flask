FROM python:3.8.8-slim-buster

COPY ./requirements.txt ./
RUN pip install -r requirements.txt

RUN useradd --create-home app
WORKDIR /home/app
USER app

COPY --chown=app:app . .

EXPOSE 5000

CMD ["gunicorn", "-c", "gunicorn.conf.py"]

ENTRYPOINT ["./docker-entrypoint"]
