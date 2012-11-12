#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/VIC/collection/master/master-with-pids.xml \
	-xsl:/srv/fedora-working/ingest/bin/xslt/ObjectAddModifyDatastream.xsl \
	-o:/srv/fedora-working/ingest/VIC/collection/modify/addMarcXMLDS.xml \
        dsLocationPath="/srv/fedora-working/ingest/VIC/collection/marcXML/" \
        dsFilenameElement="marcxmlFilename" \
        dsId="marcXML" \
        dsLabel="MARCXML data from Aleph for this collection" \
        logMessage="Adding marcXML datastream"
