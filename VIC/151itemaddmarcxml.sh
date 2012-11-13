#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/VIC/item/master/master-with-pids.xml \
	-xsl:/srv/fedora-working/ingest/bin/xslt/ObjectAddModifyDatastream.xsl \
	-o:/srv/fedora-working/ingest/VIC/item/modify/addMarcXMLDS.xml \
        dsLocationPath="/srv/fedora-working/ingest/VIC/item/marcXML/" \
        dsFilenameElement="marcxmlFilename" \
        dsId="marcXML" \
        dsLabel="MARCXML data from Aleph for this item" \
        logMessage="Adding marcXML datastream"
