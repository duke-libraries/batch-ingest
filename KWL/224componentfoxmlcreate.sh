#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/KWL/component/kwlpwpdf.xml \
	-xsl:/srv/fedora-working/xslt/ingest/ComponentFoxmlCreate.xsl \
	-o:/srv/fedora-working/ingest/KWL/component/master/component-master-kwlpwpdf.xml \
        autoParentId='true()' \
	autoParentIdLength=10 \
	checksumFilename=sha256_na_KWL.xml \
	collectioncode=KWL \
	digitizationguideFilename=digguide_kwilecki_photographs.xml \
	haveDigitizationguide='true()' \
	haveMods='true()' \
	label="Paul Kwilecki Photographs and Papers PDF"
