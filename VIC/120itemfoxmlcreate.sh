#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/VIC/item/master/master.xml \
	-xsl:/srv/fedora-working/ingest/bin/xslt/ObjectFoxmlCreate.xsl \
	-o:/srv/fedora-working/ingest/VIC/logs/item-foxml-create.xml \
        foxmlFilePath="/srv/fedora-working/ingest/VIC/item/foxml/" \
        label="Vica Nazi Propaganda Comics Item"
