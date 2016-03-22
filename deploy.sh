#!/bin/bash  
#defined 
TOMCAT_HOME="/opt/tomcat"  
TOMCAT_PORT=8080
REMOTE_IP="10.2.2.141"

#kill tomcat process
tomcat_pid=`/usr/sbin/lsof -n -P -t -i :$TOMCAT_PORT`  
echo "current :" $tomcat_pid 
if [ -n "$tomcat_pid" ]
then
echo "kill tomcat"
kill -9 "$tomcat_pid"
fi 
#check tomcat process whether has been killed
while [ -n "$tomcat_pid" ]  
do  
 sleep 5  
 tomcat_pid=`/usr/sbin/lsof -n -P -t -i :$TOMCAT_PORT`  
 echo "scan tomcat pid :" $tomcat_pid  
done  
#publish project copy jenkins
echo "scan no tomcat pid,$PROJECT publishing"  
rm -rf "$TOMCAT_HOME"/webapps/$PROJECT* 
scp -r root@"$REMOTE_IP":/usr/wars/* "$TOMCAT_HOME"/webapps/

#remove tmp  
#rm -rf "$JENKINS_HOME"/workspace/$PROJECT*/$PROJECT/target/$PROJECT*.war
#start tomcat  
"$TOMCAT_HOME"/bin/startup.sh  
echo "tomcat is starting,please try to access $PROJECT conslone url"