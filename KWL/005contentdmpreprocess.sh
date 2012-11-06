#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/KWL/cdm/export.xml \
	-xsl:/srv/fedora-working/xslt/ingest/CDMPreProc.xsl \
	-o:/srv/fedora-working/ingest/KWL/cdm/cdmpreproc.xml \
        collectioncode=KWL
