#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/VIC/collection/master/master.xml \
	-xsl:/srv/fedora-working/ingest/bin/xslt/AddPids2Master.xsl \
	-o:/srv/fedora-working/ingest/VIC/collection/master/master-with-pids.xml \
        collectioncode=VIC \
        objecttype=collection
