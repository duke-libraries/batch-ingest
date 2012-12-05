#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/KWL/collection/master/master-with-pids.xml \
	-xsl:/srv/fedora-working/ingest/bin/xslt/RelsExtFromPidMaster.xsl \
	-o:/srv/fedora-working/ingest/KWL/collection/modify/addRelsExtDS.xml \
        contentModels="afmodel:Collection" \
        adminPolicy="duke-apo:kwilecki"




























"
