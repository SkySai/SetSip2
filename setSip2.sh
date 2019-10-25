#!/bin/bash

auth="admin:admin"

if [ "$#" -eq 1 ]; then
    ip=$1
elif [ "$#" -eq 2 ]; then
    auth=$1
    ip=$2
else
    echo "USAGE: setSipDetails [auth] ip"
    echo "auth: specify username and password when non default (admin:admin) include the colon to separate the username from the password"
    echo "ip: specify endpoint IP address"
    exit 1
fi

##Sip2 config parameters##

# 0 = SIP is not enabled
# 1 = SIP is enabled
bIsSipEnabled="1"
userName="ZZZZc"
authName="SIP Auth Name"
authPassword="SIP AUTH PASSWORD"
# 0 = AUTO
# 1 = OCS
# 2 = OCS_MANUAL
serverType="0"
# 0 = registrar is not enabled
# 1 = registrar is enabled
bIsRegistrarEnabled="1"
registrarHostName="Registrar Hostname"
# 0 = SIP proxy is not enabled
# 1 = SIP proxy is enabled
bIsProxyEnabled="1"
proxyHostName="SIP proxy name"
# 0 = SIP uses direct mode registration
# 1 = SIP uses proxy mode registration
bUseProxyForRegistration="0"
# 0 = SIP auto transport
# 1 = SIP UDP only
# 2 = SIP TCP only
# 3 = SIP TLS only
transport="0"
# 0 = SIP TCP not enabled
# 1 = SIP TCP enabled
bIsTransportTCP="1"
internalServer="Internal Server"
externalServer="External Server"
# 0 = SIP Primary context
# 1 = SIP Secondary context
eContextType="1"

##END Sip2 config parameters##


echo "AUTH is ${auth}"
b64auth=$(echo -n ${auth} | base64)
echo "IP is ${ip}"

session=$( curl -H "Authorization: LSBasic ${b64auth}" -H "Content-Type: application/json" http://$ip/rest/new | awk -F\" '/session/ { print $4 }' )
echo "SESSION is ${session}"

curl -H "Authorization: LSBasic ${b64auth}" -H "Content-Type: application/json" --data "{\"call\":\"Comm_setSipDetails\",\"params\":{\"pSipDetails\":{\"bIsSipEnabled\":${bIsSipEnabled},\"userName\":\"${userName}\",\"authName\":\"${authName}\",\"authPassword\":\"${authPassword}\",\"eSipServerType\":\"${serverType}\",\"sStructAuto\":{\"bIsRegistrarEnabled\":${bIsRegistrarEnabled},\"registrarHostName\":\"${registrarHostName}\",\"bIsProxyEnabled\":${bIsProxyEnabled},\"proxyHostName\":\"${proxyHostName}\",\"bUseProxyForRegistration\":${bUseProxyForRegistration},\"transport\":\"${transport}\"},\"sStructOCSManual\":{\"bIsTransportTCP\":${bIsTransportTCP},\"internalServer\":\"${internalServer}\",\"externalServer\":\"${externalServer}\"}},\"eContextType\":${eContextType}}}" http://${ip}/rest/request/${session} 

curl -H "Authorization: LSBasic ${b64auth}" -H "Content-Type: application/json" --data "{\"params\":{},\"call\":\"SysAdmin_getTime\"}" http://${ip}/rest/request/${session} 

