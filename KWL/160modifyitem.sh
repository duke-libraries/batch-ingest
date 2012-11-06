#!/bin/sh
source /srv/fedora-working/ingest/bin/fedoraconnect.sh
/fedora/client/bin/fedora-modify.sh \
	${FEDORA_HOST}:$FEDORA_PORT \
	$FEDORA_USERNAME \
	$FEDORA_PASSWORD \
        /srv/fedora-working/ingest/KWL/item/modify/modify.xml \
        /srv/fedora-working/ingest/KWL/logs/modify-item.log \
	$FEDORA_SCHEME \
        execute
