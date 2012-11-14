#!/bin/sh
source /srv/fedora-working/ingest/bin/fedoraconnect.sh
/fedora/client/bin/fedora-modify.sh \
        ${FEDORA_HOST}:$FEDORA_PORT \
        $FEDORA_USERNAME \
        $FEDORA_PASSWORD \
        /srv/fedora-working/ingest/VIC/item/modify/addRelsExtDS.xml \
        /srv/fedora-working/ingest/VIC/logs/modify-item-addRelsExtDS.log \
	$FEDORA_SCHEME \
        execute
