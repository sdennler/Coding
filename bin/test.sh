#!/bin/sh
echo $0 $1 $2 $3
sleep 3
if [ $2 -ge 5 ]; then; exit $3; fi
exit $1