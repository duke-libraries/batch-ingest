#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/VIC/item/master/item-master-with-pids.xml \
	-xsl:/srv/fedora-working/xslt/ingest/ContentMetadataFromItemAndComponentMaster.xsl \
	-o:/srv/fedora-working/ingest/VIC/item/modify/modifyContentMetadata.xml \
        componentpidmasterfile="file:///srv/fedora-working/ingest/VIC/component/master/component-master-with-pids.xml" \
        contentmetadatafilepath="/srv/fedora-working/ingest/VIC/item/contentMetadata/"
