#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/KWL/collection/collection.xml \
	-xsl:/srv/fedora-working/xslt/ingest/CollectionFoxmlCreate.xsl \
	-o:/srv/fedora-working/ingest/KWL/collection/master/collection-master.xml \
        collectioncode=KWL \
        label="Paul Kwilecki Photographs and Papers Collection" \
        collectionTripodmetsPath="/nas/TUCASI_CIFS5/access/images/static/xml/mets/kwilecki/" \
	haveContentdm='true()' \
        haveMarcxml='true()' \
        haveMods='true()' \
        haveTripodmets='true()' \
	haveDigitizationguide='true()' \
        haveDpcmetadata='true()' \
	haveFmpexport='true()'
