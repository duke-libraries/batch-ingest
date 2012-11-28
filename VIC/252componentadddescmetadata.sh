#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/VIC/component/master/master-with-pids.xml \
	-xsl:/srv/fedora-working/ingest/bin/xslt/ObjectAddModifyDatastream.xsl \
	-o:/srv/fedora-working/ingest/VIC/component/modify/addDescMetadataDS.xml \
        dsLocationPath="/srv/fedora-working/ingest/VIC/component/qdc/" \
        dsId="descMetadata" \
        dsLabel="Descriptive Metadata for this component" \
        logMessage="Adding descMetadata datastream"
