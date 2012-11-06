#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/VIC/collection/collection.xml \
	-xsl:/srv/fedora-working/xslt/ingest/CollectionFoxmlCreate.xsl \
	-o:/srv/fedora-working/ingest/VIC/collection/master/collection-master.xml \
        collectioncode=VIC \
        label="Vica Nazi Propaganda Comics Collection" \
        collectionTripodmetsPath="/nas/TUCASI_CIFS5/access/images/static/xml/mets/vica/" \
        haveMarcxml='true()' \
        haveMods='true()' \
        haveTripodmets='true()' \
	haveDigitizationguide='true()' \
	haveFmpexport='true()'
