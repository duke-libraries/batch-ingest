#!/bin/sh
java -jar /srv/fedora-working/saxon/saxon9he.jar \
	-s:/srv/fedora-working/ingest/VIC/component/digitizationGuide/Vica_Items.xml \
	-xsl:/srv/fedora-working/ingest/bin/xslt/DigitizationGuidePreProc.xsl \
	-o:/srv/fedora-working/ingest/VIC/log/component-digitization-guide-preproc.xml \
        digitizationGuideFilePath="/srv/fedora-working/ingest/VIC/component/digitizationGuide/" \
        qdcFilePath="/srv/fedora-working/ingest/VIC/component/qdc/"
