#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/VIC/collection/master/master-with-pids.xml \
	-xsl:/srv/fedora-working/ingest/bin/xslt/ObjectAddModifyDatastream.xsl \
	-o:/srv/fedora-working/ingest/VIC/collection/modify/addDescMetadataDS.xml \
        dsLocationPath="/srv/fedora-working/ingest/VIC/collection/qdc/" \
        dsFilenameElement="qdcFilename" \
        dsId="descMetadata" \
        dsLabel="Descriptive Metadata for this collection" \
        logMessage="Adding descMetadata datastream"
