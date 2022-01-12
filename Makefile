.PHONY: bootstrap clean lint test run
.DEFAULT_GOAL := run

test: clean lint
	@python -m pytest --co -v

run: test
	@python main.py

lint:
	@python -m flake8 .

clean:
	@find . ! \( -path './venv' -prune \) -type f -name '*.pyc' -delete

bootstrap:
	@poetry install

IMAGE_NAME = opklnm102/hello-flask
VERSION := $(shell git rev-parse HEAD)
IMAGE = $(IMAGE_NAME):$(VERSION)

.PHONY: build-image
build-image:
	docker build -t $(IMAGE) -f ./Dockerfile .
	docker tag $(IMAGE) $(IMAGE_NAME):latest

.PHONY: push-image
push-image: build-image
	docker push $(IMAGE)
	docker push $(IMAGE_NAME):latest

.PHONY: clean-image
clean-image:
	docker image rm -f $(IMAGE)

.PHONY: run-container
run-container:
	docker run --rm -p 5000:5000 -p 9091:9091 $(IMAGE)
