#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/VIC/component/master/component-master.xml \
	-xsl:/srv/fedora-working/xslt/ingest/AddPids2Master.xsl \
	-o:/srv/fedora-working/ingest/VIC/component/master/component-master-with-pids.xml \
        collectioncode=VIC \
        objecttype=component
