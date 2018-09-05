#!/bin/tcsh 

set apiKey="<< YOUR API KEY >>"
set deviceId="<< YOUR DEVICE ID >>"   # Endpoint Name
set resourcePath="3200/0/5501"


while(1)
  # Show current time
  echo -n `date +"%I:%M:%S"` 

  # Read from a resource (asynchronous) 
  set responseCode=`\
    curl -s -X GET -w "%{http_code}\n"\
       -o body.tmp \
      "https://api.us-east-1.mbedcloud.com/v2/endpoints/${deviceId}/${resourcePath}" \
      -H "authorization: Bearer ${apiKey}"` 

  if(${responseCode} == 202) then
    # 202 Accepted. Returns an asynchronous response ID. 
    set value=`\
      curl -s -X GET \
        https://api.us-east-1.mbedcloud.com/v2/notification/pull \
        -H "authorization: Bearer ${apiKey}" \
        | python -m json.tool \
        | grep 'payload' \
        | awk -F':' '{print $2}' \
        | sed 's/\}//g' \
        | sed 's/\"//g' \
        | base64 --decode`
    echo " btnCnt=${value}"

  else if(${responseCode} == 200) then
    # 200 Resource value found in cache. Returns the string value of the resource.  
    set cachedValue=`cat body.tmp` 
    echo " btnCnt=${cachedValue}  (cached)"

  else
    echo "${responseCode} Unexpected."

  endif

  sleep 5
end

