#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/VIC/component/master/master.xml \
	-xsl:/srv/fedora-working/ingest/bin/xslt/ObjectFoxmlCreate.xsl \
	-o:/srv/fedora-working/ingest/VIC/logs/component-foxml-create.xml \
        foxmlFilePath="/srv/fedora-working/ingest/VIC/component/foxml/" \
        label="Vica Nazi Propaganda Comics Image"

