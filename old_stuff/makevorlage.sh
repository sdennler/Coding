#!/bin/sh
ANZ_FILES=2
FILES=`ls ??.??.??.cr | sort -r`
COUNTER=0
fileList=""
for i in $FILES
do
 if [ $COUNTER -lt $ANZ_FILES ]
 then
  fileList="$fileList$i "
 fi
 COUNTER=$(($COUNTER+1))
done
echo "$fileList"
vorlage -d -w 70 -g -hb -kl -l -m -n -ox bef -pb -sb -td -un -up -us -i ~/bin/sd.vms $fileList


