#!/bin/bash

cd /mysqlossdata/
ls -lt | awk '{if(NR>=9){print $9}}' | xargs rm -f


cd /mysqldata/

ls -lt | awk '{if(NR>=9){print $9}}' | xargs rm -f



