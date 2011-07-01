#!/bin/sh
for x in `ls -w1`
do
 mv $x "`echo $x | tr _ \ `"
done