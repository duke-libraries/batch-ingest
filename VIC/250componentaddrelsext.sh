#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/VIC/component/master/master-with-pids.xml \
	-xsl:/srv/fedora-working/ingest/bin/xslt/RelsExtFromPidMaster.xsl \
	-o:/srv/fedora-working/ingest/VIC/component/modify/addRelsExtDS.xml \
        parentpidmasterfile="file:///srv/fedora-working/ingest/VIC/item/master/master-with-pids.xml" \
        relationshiptoparent="isPartOf" \
        contentModels="afmodel:Component" \
        adminPolicy="duke-apo:vica"