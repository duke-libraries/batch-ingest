#!/bin/sh
INGESTDIR="/srv/fedora-working/ingest/VIC"
DATASTREAMS="DC,RELS-EXT,content,JHOVE"
MASTERFILE="${INGESTDIR}/component/master/component-master-with-pids.xml"
LOGFILE="${INGESTDIR}/logs/validate-components.log"
/srv/fedora-working/scripts/component-master-validator.sh -f ${MASTERFILE} -d "${DATASTREAMS}" 2> ${LOGFILE}
