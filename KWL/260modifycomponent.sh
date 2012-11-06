#!/bin/sh
source /srv/fedora-working/ingest/bin/fedoraconnect.sh
/fedora/client/bin/fedora-modify.sh \
	${FEDORA_HOST}:$FEDORA_PORT \
	$FEDORA_USERNAME \
	$FEDORA_PASSWORD \
        /srv/fedora-working/ingest/KWL/component/modify/modify.xml \
        /srv/fedora-working/ingest/KWL/logs/modify-component.log \
	$FEDORA_SCHEME \
        execute
