#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/VIC/collection/master/master-with-pids.xml \
	-xsl:/srv/fedora-working/ingest/bin/xslt/ObjectAddModifyDatastream.xsl \
	-o:/srv/fedora-working/ingest/VIC/collection/modify/addFmpExportDS.xml \
        dsLocationPath="/srv/fedora-working/ingest/VIC/collection/fmpExport/" \
        dsFilenameElement="fmpexportFilename" \
        dsId="fmpExport" \
        dsLabel="FileMaker Pro export data for this collection" \
        logMessage="Adding fmpExport datastream"
