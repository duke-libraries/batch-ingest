#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/KWL/item/master/item-master-with-pids.xml \
	-xsl:/srv/fedora-working/xslt/ingest/ContentMetadataFromItemAndComponentMaster.xsl \
	-o:/srv/fedora-working/ingest/KWL/item/modify/modifyContentMetadatakwlpw.xml \
        componentpidmasterfile="file:///srv/fedora-working/ingest/KWL/component/master/component-master-with-pids.xml" \
	itemPrefix=kwlpw \
        contentmetadatafilepath="/srv/fedora-working/ingest/KWL/item/contentMetadata/"
