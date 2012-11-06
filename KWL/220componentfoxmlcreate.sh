#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/KWL/component/kwlph.xml \
	-xsl:/srv/fedora-working/xslt/ingest/ComponentFoxmlCreate.xsl \
	-o:/srv/fedora-working/ingest/KWL/component/master/component-master-kwlph.xml \
        autoParentId='true()' \
	autoParentIdLength=14 \
	checksumFilename=sha256_na_KWL.xml \
	collectioncode=KWL \
	digitizationguideFilename=digguide_kwilecki_photographs.xml \
	haveDigitizationguide='true()' \
	haveMods='true()' \
	label="Paul Kwilecki Photographs and Papers Image"
