#!/bin/bash
set -x
VAR=""
. /home/eirsapp/.bash_profile
build_path=$1
alertUrl=http://10.100.1.131:9509/eirs/alert/

function generateAlertUsingUrl() {
    alertId="alert_5000"
    alertMessage="No properties file found at location $build_path"
    alertProcess="AUTO"
#    alertUrl=$4
    curlOutput=$(curl --header "Content-Type: application/json"   --request POST   --data '{"alertId":"'$alertId'",
    "alertMessage":"'"$alertMessage"'", "userId": "0", "alertProcess": "'"$alertProcess"'"}' "$alertUrl")
    echo $curlOutput
}


status=`ls $build_path | grep application`
if  [ "$status" == "$VAR" ]
then
 echo "Application properties/yml file not found at location $build_path"
 generateAlertUsingUrl 
else
 echo "Application properties/yml file found -- $status " 
 exit
fi


