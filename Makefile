SHELL=/bin/bash -o pipefail

REGISTRY   ?= kubedb
BIN        := postgres_exporter
IMAGE      := $(REGISTRY)/$(BIN)
DB_VERSION := v0.4.7
TAG        := $(shell git describe --exact-match --abbrev=0 2>/dev/null || echo "")

.PHONY: push
push: container
	docker push $(IMAGE):$(TAG)

.PHONY: container
container:
	docker pull wrouesnel/postgres_exporter:$(DB_VERSION)
	docker tag wrouesnel/postgres_exporter:$(DB_VERSION) $(IMAGE):$(TAG)

.PHONY: version
version:
	@echo ::set-output name=version::$(TAG)
