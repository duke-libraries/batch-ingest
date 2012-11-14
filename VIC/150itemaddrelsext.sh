#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/VIC/item/master/master-with-pids.xml \
	-xsl:/srv/fedora-working/ingest/bin/xslt/RelsExtFromPidMaster.xsl \
	-o:/srv/fedora-working/ingest/VIC/item/modify/addRelsExtDS.xml \
        parentpidmasterfile="file:///srv/fedora-working/ingest/VIC/collection/master/master-with-pids.xml" \
        relationshiptoparent="isMemberOf" \
        contentModels="afmodel:Item" \
        adminPolicy="duke-apo:vica"
