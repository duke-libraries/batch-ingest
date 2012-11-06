#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/KWL/component/kwlpw.xml \
	-xsl:/srv/fedora-working/xslt/ingest/ComponentFoxmlCreate.xsl \
	-o:/srv/fedora-working/ingest/KWL/component/master/component-master-kwlpw.xml \
        autoParentId='true()' \
	autoParentIdLength=10 \
	checksumFilename=sha256_na_KWL.xml \
	collectioncode=KWL \
	haveMods='true()' \
	label="Paul Kwilecki Photographs and Papers Image"
