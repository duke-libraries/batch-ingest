#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon.jar \
        -o /srv/fedora-working/ingest/VIC/collection/mods/vica.xml \
        /srv/fedora-working/ingest/VIC/collection/marcXML/vica.xml \
        /srv/fedora-working/xslt/ingest/MARC21slim2MODS3-4.xsl 
