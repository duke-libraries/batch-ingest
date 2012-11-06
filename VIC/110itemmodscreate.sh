#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon.jar \
        -o /srv/fedora-working/ingest/VIC/item/mods/003018898.xml \
        /srv/fedora-working/ingest/VIC/item/marcXML/003018898.xml \
        /srv/fedora-working/xslt/ingest/MARC21slim2MODS3-4.xsl 
java -jar /srv/fedora-working/saxon/saxon.jar \
        -o /srv/fedora-working/ingest/VIC/item/mods/003018899.xml \
        /srv/fedora-working/ingest/VIC/item/marcXML/003018899.xml \
        /srv/fedora-working/xslt/ingest/MARC21slim2MODS3-4.xsl 
java -jar /srv/fedora-working/saxon/saxon.jar \
        -o /srv/fedora-working/ingest/VIC/item/mods/003018900.xml \
        /srv/fedora-working/ingest/VIC/item/marcXML/003018900.xml \
        /srv/fedora-working/xslt/ingest/MARC21slim2MODS3-4.xsl 
