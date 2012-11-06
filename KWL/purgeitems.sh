#!/bin/sh
source /srv/fedora-working/ingest/bin/fedoraconnect.sh
/fedora/client/bin/fedora-purge.sh \
	${FEDORA_HOST}:$FEDORA_PORT \
	$FEDORA_USERNAME \
	$FEDORA_PASSWORD \
	file:///srv/fedora-working/ingest/KWL/purge/items.txt \
	$FEDORA_SCHEME \
	"cleaning up" \
	$FEDORA_CONTEXT
