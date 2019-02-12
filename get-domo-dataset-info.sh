#!/bin/bash

set -ue

function main() {
  # TODO: Please replace the followings with your client ID and secret
  local -r CLIENT_ID=YOUR_CLIENT_ID
  local -r CLIENT_SECRET=YOUR_CLIENT_SECRET

  local -r SCOPE=data

  echo "Get access token. Client ID = ${CLIENT_ID}"

  curl -s -u $CLIENT_ID:$CLIENT_SECRET "https://api.domo.com/oauth/token?grant_type=client_credentials&scope=${SCOPE}" | jq .
  local -r ACCESS_TOKEN=$(curl -s -u $CLIENT_ID:$CLIENT_SECRET "https://api.domo.com/oauth/token?grant_type=client_credentials&scope=${SCOPE}" | jq .access_token | sed -E 's/(^")|("$)//g')

  # TODO: Please replace the following with a Domo DataSet ID you want to get info
  local -r DATASET_ID=YOUR_DATASET_ID

  echo "Get DataSet info. id = ${DATASET_ID}"
  local -r json_result=$(curl -s -X GET "https://api.domo.com/v1/datasets/$DATASET_ID" -H "Authorization: bearer ${ACCESS_TOKEN}")
  echo "  Response: $(echo $json_result | jq .)"
  echo $json_result | jq '.id, .name, .owner.name'
}

main
