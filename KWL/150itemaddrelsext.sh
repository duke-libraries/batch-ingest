#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/KWL/item/master/item-master-with-pids.xml \
	-xsl:/srv/fedora-working/xslt/ingest/RelsExtFromPidMaster.xsl \
	-o:/srv/fedora-working/ingest/KWL/item/modify/modify.xml \
        parentpidmasterfile="file:///srv/fedora-working/ingest/KWL/collection/master/collection-master-with-pids.xml" \
        relationshiptoparent="isMemberOf" \
        contentModels="afmodel:Item"
