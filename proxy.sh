#!/bin/bash
a=/root/result.txt
num=0
ip=10.2.2.251
#echo $a
for port in 50001 50002 50003 50004 50005 50006

do
#做5次循环判断代理是否可用

for(( i=0; i<=4; i=i+1 ))
do
curl -x $ip:$port -I https://www.baidu.com -o $a

#把结果中取出状态码
status=`awk 'NR==1{print}' $a | awk '{print$2}'`
#echo "$status:1"
#判断如果等于200则不操作，不等于200就num加一

if [ $status == 200  ]; then

#let num=$num+1 

cat /dev/null > $a

else

#echo "bad"

let num=$num+1
cat /dev/null > $a

fi

done

echo $num

#如果num也就是失败次数大于2，就发邮件

if [ $num -ge 2 ];then


echo "proxy $ip:$port failed $num times " |mail -s "proxy $ip:$port failed $num times" alert@bundcredit.com


fi
num=0

done
