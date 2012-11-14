#!/bin/sh
source /srv/fedora-working/ingest/bin/fedoraconnect.sh
/fedora/client/bin/fedora-modify.sh \
        ${FEDORA_HOST}:$FEDORA_PORT \
        $FEDORA_USERNAME \
        $FEDORA_PASSWORD \
        /srv/fedora-working/ingest/VIC/collection/modify/addDigitizationGuideDS.xml \
        /srv/fedora-working/ingest/VIC/logs/modify-collection-addDigitizationGuideDS.log \
	$FEDORA_SCHEME \
        execute
