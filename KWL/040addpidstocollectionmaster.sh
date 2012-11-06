#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/KWL/collection/master/collection-master.xml \
	-xsl:/srv/fedora-working/xslt/ingest/AddPids2Master.xsl \
	-o:/srv/fedora-working/ingest/KWL/collection/master/collection-master-with-pids.xml \
        collectioncode=KWL \
        objecttype=collection
