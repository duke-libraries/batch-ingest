#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/VIC/component/master/master-with-pids.xml \
	-xsl:/srv/fedora-working/ingest/bin/xslt/ObjectAddModifyDatastream.xsl \
	-o:/srv/fedora-working/ingest/VIC/component/modify/addContentDS.xml \
        dsLocationPath="/nas/TUCASI_CIFS2/dpc-archive/Archived_NoAccess/na_VIC/" \
        dsFilenameExtension=".tif" \
        dsId="content" \
        dsLabel="Content for this component" \
        logMessage="Adding content datastream"
