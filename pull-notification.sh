#!/bin/tcsh 

# Endpoint URI
set uri="https://api.us-east-1.mbedcloud.com"

if($#argv < 3) then
  echo "$0 [API_KEY] [DEVICE_ID] [RESOURCE_PATH]"
  exit
endif

set apiKey=$argv[1]
set deviceId=$argv[2]
set resourcePath=$argv[3]

# Read from a resource (asynchronous) 
set responseCode=`\
  curl -s -X GET -w "%{http_code}\n"\
      -o body.tmp \
    "${uri}/v2/endpoints/${deviceId}/${resourcePath}" \
    -H "authorization: Bearer ${apiKey}"` 

if(${responseCode} == 202) then
  # 202 Accepted. Returns an asynchronous response ID. 
  curl -s -X GET \
      "${uri}/v2/notification/pull" \
      -H "authorization: Bearer ${apiKey}" \
      | python -m json.tool \
      | grep 'payload' \
      | awk -F':' '{print $2}' \
      | sed 's/\}//g' \
      | sed 's/\"//g' \
      | base64 --decode \
      > `date "+%Y%m%d-%H%M%S"`.jpg 
#      > `date "+%Y%m%d-%H%M%S"`.json


else if(${responseCode} == 200) then
  # 200 Resource value found in cache. Returns the string value of the resource.  
  cat body.tmp  
else
  echo "${responseCode} Unexpected."
endif

# clean up
rm body.tmp

