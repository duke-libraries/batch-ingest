#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/KWL/item/items.xml \
	-xsl:/srv/fedora-working/xslt/ingest/ItemFoxmlCreate.xsl \
	-o:/srv/fedora-working/ingest/KWL/item/master/item-master.xml \
        collectioncode=KWL \
        label="Paul Kwilecki Photographs and Papers Item" \
        parentId=kwilecki \
        itemTripodmetsPath="/nas/TUCASI_CIFS5/access/images/static/xml/mets/kwilecki/" \
        haveContentdm='true()' \
        haveMods='true()' \
        haveTripodmets='true()'
