#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/KWL/item/master/item-master-with-pids.xml \
	-xsl:/srv/fedora-working/xslt/ingest/ContentMetadataFromItemAndComponentMaster.xsl \
	-o:/srv/fedora-working/ingest/KWL/item/modify/modifyContentMetadatakwlph.xml \
        componentpidmasterfile="file:///srv/fedora-working/ingest/KWL/component/master/component-master-with-pids.xml" \
	itemPrefix=kwlph \
	fileNumberStart=8 \
        contentmetadatafilepath="/srv/fedora-working/ingest/KWL/item/contentMetadata/"
