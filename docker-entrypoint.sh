#!/bin/bash
set -e

# Add kibana as command if needed
if [[ "$1" == -* ]]; then
	set -- kibana "$@"
fi

# Run as user "kibana" if the command is "kibana"
if [ "$1" = 'kibana' ]; then
  sed -ri "s!^(\#\s*)?(elasticsearch\.url:).*!\2 '${ES_URL-http://elasticsearch:9200}'!" /usr/share/kibana/config/kibana.yml
	set -- su-exec kibana /sbin/tini -- "$@"
fi

exec "$@"
