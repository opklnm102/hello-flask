.PHONY: bootstrap clean lint test run
.DEFAULT_GOAL := run

test: clean lint
	# @py.test test/ --cov app.py -s

run: test
	@python main.py

lint:
	@flake8 .

clean:
	@find . ! \( -path './venv' -prune \) -type f -name '*.pyc' -delete

bootstrap:
	@pip install -r requirements.txt
	@python setup.py develop

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
