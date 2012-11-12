#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon.jar \
        -o /srv/fedora-working/ingest/VIC/collection/qdc/vica.xml \
        /srv/fedora-working/ingest/VIC/collection/marcXML/vica.xml \
        /srv/fedora-working/ingest/bin/xslt/MARCXML2QDC.xsl 
