#!/bin/bash

set -e

if [ ! -d "output" ]; then
    echo "No output directory!"
    exit 1
fi

BRANCH_NAME=`git rev-parse --abbrev-ref HEAD`

SANITIZED_BRANCH_NAME=`echo "${BRANCH_NAME}" | tr A-Z a-z | sed -e 's/[^a-zA-Z0-9\-]/-/g'`
SANITIZED_BRANCH_NAME=`echo "${SANITIZED_BRANCH_NAME}" | sed 's/\(--*\)/-/g'`
DEPLOY_DIRECTORY_NAME="${SANITIZED_BRANCH_NAME}.static-staging.ikennd.ac"

echo "Deploying ${BRANCH_NAME} to ${DEPLOY_DIRECTORY_NAME}.ac…"

rsync -r --links --safe-links output/ "website_deployment@static-staging.ikennd.ac:/ikenndac/public_html/content/${DEPLOY_DIRECTORY_NAME}/"
