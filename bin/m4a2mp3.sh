#!/bin/bash
for i in *.m4a
do
 file=`basename "$i" .m4a`
 ffmpeg -i "$i"  -ab 256k "$file".mp3
done
