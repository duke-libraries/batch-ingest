#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/VIC/item/items.xml \
	-xsl:/srv/fedora-working/xslt/ingest/ItemFoxmlCreate.xsl \
	-o:/srv/fedora-working/ingest/VIC/item/master/item-master.xml \
        collectioncode=VIC \
        label="Vica Nazi Propaganda Comics Item" \
        autoParentId='true()' \
        autoParentIdLength=5 \
        itemTripodmetsPath="/nas/TUCASI_CIFS5/access/images/static/xml/mets/vica/" \
        haveMarcxml='true()' \
        haveMods='true()' \
        haveTripodmets='true()'
