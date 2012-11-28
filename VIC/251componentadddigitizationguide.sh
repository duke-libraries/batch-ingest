#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/VIC/component/master/master-with-pids.xml \
	-xsl:/srv/fedora-working/ingest/bin/xslt/ObjectAddModifyDatastream.xsl \
	-o:/srv/fedora-working/ingest/VIC/component/modify/addDigitizationGuideDS.xml \
        dsLocationPath="/srv/fedora-working/ingest/VIC/component/digitizationGuide/" \
        dsId="digitizationGuide" \
        dsLabel="Digitization Guide data for this component" \
        logMessage="Adding digitizationGuide datastream"
