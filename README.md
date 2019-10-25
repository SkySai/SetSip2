# SetSip2
CURL against Icon API to configure 'config sip reg 2'

USAGE: You can invoke this script in two ways

- ./setSip2.sh <password> <IPofMachine>
- ./batchRun.sh <password <IpFile.txt>
  
Notes* <br />
Customer will need a Linux or MAC machine with CURL utility installed.  
Password parameter is optional.  
Script assumes a default password of ‘admin/admin’ if no password parameter is given.  
You'll need to edit the setSip2.sh file with the appropriate Sip server/authoriation credentials. I have sectioned off this parameter area with the following text > '##Sip2 config parameters##'

Optional batchRun.sh takes a file with a list of IPs this script will operate over. See ExampleFile.txt for formatting examples.

