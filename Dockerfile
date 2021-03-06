FROM alpine:3.5

ARG KIBANA_VERSION

RUN set -x \
  && apk add --update openssl ca-certificates \
  && apk add --update ca-certificates wget \
  && update-ca-certificates \
	&& wget -O /usr/share/kibana-${KIBANA_VERSION}.tar.gz https://artifacts.elastic.co/downloads/kibana/kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz \
	&& cd /usr/share \
	&& tar xf kibana-${KIBANA_VERSION}.tar.gz \
	&& mv kibana-${KIBANA_VERSION}-linux-x86_64 kibana \
	&& sed -ri "s!^(\#\s*)?(server\.host:).*!\2 '0.0.0.0'!" /usr/share/kibana/config/kibana.yml \
	&& grep -q "^server\.host: '0.0.0.0'\$" /usr/share/kibana/config/kibana.yml \
	&& sed -ri "s!^(\#\s*)?(elasticsearch\.url:).*!\2 'http://elasticsearch:9200'!" /usr/share/kibana/config/kibana.yml \
	&& grep -q "^elasticsearch\.url: 'http://elasticsearch:9200'\$" /usr/share/kibana/config/kibana.yml \
	&& apk add --no-cache \
		nodejs \
		su-exec \
		bash \
		tini \
    zip \
	&& addgroup kibana \
  && adduser -S -D -G kibana -h /usr/share/kibana/ kibana \
  && chown -R kibana:kibana /usr/share/kibana \
	&& rm -rf /usr/share/kibana/node \
	&& rm -f /usr/share/kibana-${KIBANA_VERSION}.tar.gz

ENV PATH /usr/share/kibana/bin:$PATH

COPY docker-entrypoint.sh /

EXPOSE 5601

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["kibana"]
