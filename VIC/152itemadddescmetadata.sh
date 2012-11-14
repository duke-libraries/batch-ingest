#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/VIC/item/master/master-with-pids.xml \
	-xsl:/srv/fedora-working/ingest/bin/xslt/ObjectAddModifyDatastream.xsl \
	-o:/srv/fedora-working/ingest/VIC/item/modify/addDescMetadataDS.xml \
        dsLocationPath="/srv/fedora-working/ingest/VIC/item/qdc/" \
        dsFilenameElement="qdcFilename" \
        dsId="descMetadata" \
        dsLabel="Descriptive Metadata for this item" \
        logMessage="Adding descMetadata datastream"
