#!/bin/sh
source /srv/fedora-working/ingest/bin/fedoraconnect.sh
/fedora/client/bin/fedora-batch-ingest.sh \
	/srv/fedora-working/ingest/VIC/collection/foxml \
        /srv/fedora-working/ingest/VIC/logs/ingest-collection.log \
	xml \
        info:fedora/fedora-system:FOXML-1.1 \
	${FEDORA_HOST}:$FEDORA_PORT \
	$FEDORA_USERNAME \
	$FEDORA_PASSWORD \
	$FEDORA_SCHEME \
	$FEDORA_CONTEXT
