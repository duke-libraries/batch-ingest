#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/VIC/item/master/master-with-pids.xml \
	-xsl:/srv/fedora-working/ingest/bin/xslt/ObjectAddModifyDatastream.xsl \
	-o:/srv/fedora-working/ingest/VIC/item/modify/addTripodMetsDS.xml \
        dsLocationPath="/nas/TUCASI_CIFS5/access/images/static/xml/mets/vica/" \
        dsFilenameElement="tripodmetsFilename" \
        dsId="tripodMets" \
        dsLabel="Tripod METS file for this item" \
        logMessage="Adding tripodMets datastream"
