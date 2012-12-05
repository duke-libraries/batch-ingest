#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/KWL/collection/master/master.xml \
	-xsl:/srv/fedora-working/ingest/bin/xslt/ObjectFoxmlCreate.xsl \
	-o:/srv/fedora-working/ingest/KWL/logs/collection-foxml-create.xml \
        foxmlFilePath="/srv/fedora-working/ingest/KWL/collection/foxml/" \
        label="Paul Kwilecki Photographs and Papers Collection"
