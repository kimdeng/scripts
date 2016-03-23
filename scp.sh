#!/bin/bash

cd /
for i in `ls /python`

do 

file=/python/$i
echo $file
expect scp.exp $file

done

  
