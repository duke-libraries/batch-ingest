#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/VIC/component/components.xml \
	-xsl:/srv/fedora-working/xslt/ingest/ComponentFoxmlCreate.xsl \
	-o:/srv/fedora-working/ingest/VIC/component/master/component-master.xml \
        autoParentId='true()' \
	autoParentIdLength=7 \
	checksumFilename=vic_sha256_checksums.xml \
	collectioncode=VIC \
	digitizationguideFilename=Vica_Items.xml \
	haveDigitizationguide='true()' \
	haveMods='true()' \
	label="Vica Nazi Propaganda Comics Image"
