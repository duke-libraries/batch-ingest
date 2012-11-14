#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/jhove/output/na_VIC.xml \
	-xsl:/srv/fedora-working/ingest/bin/xslt/JhovePreProc.xsl \
	-o:/srv/fedora-working/ingest/VIC/component/master/master.xml \
        jhoveFilePath="/srv/fedora-working/ingest/VIC/component/jhove/" \
        model="afmodel:Component"
