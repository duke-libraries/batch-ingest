#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/jhove/output/na_KWL.xml \
	-xsl:/srv/fedora-working/xslt/ingest/JhovePreProc.xsl \
	-o:/srv/fedora-working/ingest/KWL/component/components.xml \
        collectioncode=KWL 
