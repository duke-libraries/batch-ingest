#!/bin/sh
source /srv/fedora-working/ingest/bin/fedoraconnect.sh
/fedora/client/bin/fedora-modify.sh \
        ${FEDORA_HOST}:$FEDORA_PORT \
        $FEDORA_USERNAME \
        $FEDORA_PASSWORD \
        /srv/fedora-working/ingest/VIC/component/modify/addDigitizationGuideDS.xml \
        /srv/fedora-working/ingest/VIC/logs/modify-component-addDigitizationGuideDS.log \
	$FEDORA_SCHEME \
        execute
