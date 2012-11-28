#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/jhove/output/na_VIC.xml \
	-xsl:/srv/fedora-working/ingest/bin/xslt/JhovePreProc.xsl \
	-o:/srv/fedora-working/ingest/VIC/component/master/master.xml \
        jhoveFilePath="/srv/fedora-working/ingest/VIC/component/jhove/" \
        model="afmodel:Component" \
	autoParentId='true()' \
	autoParentIdLength=7 \
        haveChecksum='true()' \
        checksumFilePath="/srv/fedora-working/ingest/VIC/component/checksum/vic_sha256_checksums.xml"
