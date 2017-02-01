.PHONY:	build push

ORG = "checkr"
KIBANA_VERSION = 5.1.2

build:
	docker build --build-arg KIBANA_VERSION=${KIBANA_VERSION}  -t ${ORG}/kibana:$(KIBANA_VERSION) .
