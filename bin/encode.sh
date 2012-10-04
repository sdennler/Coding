#!/bin/sh

time mencoder "$1" -profile enc -xvidencopts pass=1 -o /dev/null
time mencoder "$1" -profile enc -xvidencopts pass=2 -o "$2 $3.avi" -info name="$3":comment="Recorded on $2":artist="sam.heldenschmiede.ch"
#time mencoder "$1" -profile enc_m -lavcopts vpass=1 -o /dev/null
#time mencoder "$1" -profile enc_m -lavcopts vpass=2 -o "$2 $3.avi" -info name="$3":comment="Recorded on $2":artist="Karim Omari"
exit

# -lameopts cbr:br=128
#encode.sh ".avi" "" ""