#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
    -s:/srv/fedora-working/ingest/VIC/item/master/master-with-pids.xml \
    -xsl:/srv/fedora-working/ingest/bin/xslt/ContentMetadataFromItemAndComponentMaster.xsl \
    -o:/srv/fedora-working/ingest/VIC/item/modify/addContentMetadataDS.xml \
    componentpidmasterfile="file:///srv/fedora-working/ingest/VIC/component/master/master-with-pids.xml" \
    contentmetadatafilepath="/srv/fedora-working/ingest/VIC/item/contentMetadata/" \
    fileNumberStart=8
