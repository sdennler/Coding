#!/bin/sh

file=$1
gpsbabel -i gpx,garminextensions -f "$file" -x sort,shortname -o gpx -F - |
grep -Ev "<time>|<cmt>|<ql:key>" > "$file.s"
mv "$file.s" "$file"
