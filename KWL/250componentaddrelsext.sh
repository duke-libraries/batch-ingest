#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/KWL/component/master/component-master-with-pids.xml \
	-xsl:/srv/fedora-working/xslt/ingest/RelsExtFromPidMaster.xsl \
	-o:/srv/fedora-working/ingest/KWL/component/modify/modify.xml \
        parentpidmasterfile="file:///srv/fedora-working/ingest/KWL/item/master/item-master-with-pids.xml" \
        relationshiptoparent="isPartOf" \
        contentModels="afmodel:Component"
