#!/bin/sh
INGESTDIR="/srv/fedora-working/ingest/VIC"
DATASTREAMS="DC,RELS-EXT"
MASTERFILE="${INGESTDIR}/item/master/item-master-with-pids.xml"
LOGFILE="${INGESTDIR}/logs/validate-items.log"
/srv/fedora-working/scripts/item-master-validator.sh -f ${MASTERFILE} -d "${DATASTREAMS}" 2> ${LOGFILE}
