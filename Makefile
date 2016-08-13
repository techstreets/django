IMAGE_NAME := bradojevic/django-prod
IMAGE_TAG := 1.9.0
CONTAINER_NAME := django-app

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

MAKE_DIR:=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))

.PHONY: all clean build

all: build

build:
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) .

clean:
	docker images $(IMAGE_NAME) | grep -q $(IMAGE_TAG) && docker rmi $(IMAGE_NAME):$(IMAGE_TAG) || true

run:
	docker run --name $(CONTAINER_NAME) --restart=always -d -p 80:80 -v $(MAKE_DIR):/opt/app $(IMAGE_NAME):$(IMAGE_TAG)

kill:
	docker stop $(CONTAINER_NAME) && docker rm $(CONTAINER_NAME)
