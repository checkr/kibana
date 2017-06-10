.PHONY:	build push

ORG = "checkr"
KIBANA_VERSION = 5.3.2
LOGTRAIL_RELEASE = https://github.com/sivasamyk/logtrail/releases/download/0.1.11/logtrail-5.3.2-0.1.11.zip

build:
	docker build --build-arg KIBANA_VERSION=${KIBANA_VERSION} --build-arg LOGTRAIL_RELEASE=${LOGTRAIL_RELEASE} -t ${ORG}/kibana:$(KIBANA_VERSION) .
