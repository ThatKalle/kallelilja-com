#!/bin/bash

set -e

FILE=$1
URL=$2
CHECKSUM=$3
EXTRACT_DIR=$4

SHAFILE="${FILE}.sha256"

curl -L -o "${FILE}" "${URL}"
if [ -f "${SHAFILE}" ]; then rm "${SHAFILE}"; fi
echo "${CHECKSUM}  ${FILE}" > "${SHAFILE}"
sha256sum -c "${SHAFILE}"
tar -xzf "${FILE}" -C "${EXTRACT_DIR}"

rm "${FILE}" "${SHAFILE}"
