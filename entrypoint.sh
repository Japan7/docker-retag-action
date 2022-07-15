#!/bin/sh -l

PREVIOUS_TAG="$1"
NEW_TAGS="$2"
SERVER="$3"
USERNAME="$4"
PASSWORD="$5"
IMAGE="$6"

CONTENT_TYPE="application/vnd.docker.distribution.manifest.v2+json"

echo "Getting repository uathorization token..."
token="$(curl -s \
              -u ${USERNAME}:${PASSWORD} \
              "https://${SERVER}/token?scope=repository:${IMAGE}:pull,push" \
              | jq --raw-output .token)"

echo "Fetching Docker image manisfest..."
curl -s \
     -H "Accept: ${CONTENT_TYPE}" \
     -H "Authorization: Bearer ${token}" \
     "https://${SERVER}/v2/${IMAGE}/manifests/${PREVIOUS_TAG}" \
     > manifest.json

for new_tag in $NEW_TAGS; do
    echo "Registrering new tag \"${new_tag}\"..."
    curl -X PUT \
         -H "Content-Type: ${CONTENT_TYPE}" \
         -H "Authorization: Bearer ${token}" \
         -d @manifest.json \
         "https://${SERVER}/v2/${IMAGE}/manifests/${new_tag}"
done
