#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/VIC/collection/master/master-with-pids.xml \
	-xsl:/srv/fedora-working/ingest/bin/xslt/ObjectAddModifyDatastream.xsl \
	-o:/srv/fedora-working/ingest/VIC/collection/modify/addDigitizationGuideDS.xml \
        dsLocationPath="/srv/fedora-working/ingest/VIC/collection/digitizationGuide/" \
        dsFilenameElement="digitizationguideFilename" \
        dsId="digitizationGuide" \
        dsLabel="Digitization Guide for this collection" \
        logMessage="Adding digitizationGuide datastream"
