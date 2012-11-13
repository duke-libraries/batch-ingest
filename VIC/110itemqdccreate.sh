#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon.jar \
        -o /srv/fedora-working/ingest/VIC/item/qdc/003018898.xml \
        /srv/fedora-working/ingest/VIC/item/marcXML/003018898.xml \
        /srv/fedora-working/ingest/bin/xslt/MARCXML2QDC.xsl 
java -jar /srv/fedora-working/saxon/saxon.jar \
        -o /srv/fedora-working/ingest/VIC/item/qdc/003018899.xml \
        /srv/fedora-working/ingest/VIC/item/marcXML/003018899.xml \
        /srv/fedora-working/ingest/bin/xslt/MARCXML2QDC.xsl 
java -jar /srv/fedora-working/saxon/saxon.jar \
        -o /srv/fedora-working/ingest/VIC/item/qdc/003018900.xml \
        /srv/fedora-working/ingest/VIC/item/marcXML/003018900.xml \
        /srv/fedora-working/ingest/bin/xslt/MARCXML2QDC.xsl 
