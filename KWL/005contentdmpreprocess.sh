#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/KWL/cdm/export.xml \
	-xsl:/srv/fedora-working/ingest/bin/xslt/CDMPreProc.xsl \
	-o:/srv/fedora-working/ingest/KWL/cdm/cdmpreproc.xml \
        basepath=/srv/fedora-working/ingest/KWL/ \
        collectionmodel=afmodel:Collection \
        itemmodel=afmodel:Item
