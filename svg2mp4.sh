#!/usr/bin/env bash

set -euo pipefail

IN_FILE=$1
IN_PATH="file://`pwd`/$IN_FILE"
FPS=${2:-30}
TIME=${3:-5}
OUT_FILE=${4:-"out.mp4"}
RES_X=${5:-1280}
RES_Y=${6:-720}

JS_PATH=`dirname $0`/svg-to-mp4.js

echo "Converting up to $TIME seconds of $IN_PATH at $FPS fps. Output file: $OUT_FILE"

# Note: swapping stdout / stderr to work around ne'er-to-be-fixed PhantomJS bug
(phantomjs $JS_PATH $IN_PATH $TIME $FPS $RES_X $RES_Y 3>&2 2>&1 1>&3-) | ffmpeg -y -c:v png -f image2pipe -r 30 -t 4 -i - -c:v libx264 -pix_fmt yuv420p -vf scale=$RES_X:$RES_Y $OUT_FILE
