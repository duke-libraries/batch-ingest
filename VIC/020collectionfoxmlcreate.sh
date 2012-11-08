#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/VIC/collection/master/master.xml \
	-xsl:/srv/fedora-working/ingest/bin/xslt/ObjectFoxmlCreate.xsl \
	-o:/srv/fedora-working/ingest/VIC/log/collection-foxml-create.xml \
        foxmlFilePath="/srv/fedora-working/ingest/VIC/collection/foxml/" \
        label="Vica Nazi Propaganda Comics Collection"
