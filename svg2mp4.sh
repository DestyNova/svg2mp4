#!/usr/bin/env bash

set -euo pipefail

usage() {
  echo "Usage: $0 [opts] <filename>
  Options:
    -w <WIDTH>: Horizontal resolution
    -h <HEIGHT>: Vertical resolution
    -f <FPS>: Output FPS
    -t <TIME>: Maximum file duration in seconds
    -o <FILENAME>: Output file" 1>&2
  exit 1
}

# defaults
FPS=30
TIME=2
RES_X=1280
RES_Y=720
JS_PATH=`dirname $0`/svg-to-mp4.js
OUT_FILE=out.mp4

while getopts ":w:h:f:t:o:" opt; do
  case $opt in
    w)
      RES_X=$OPTARG
      ;;
    h)
      RES_Y=$OPTARG
      ;;
    f)
      FPS=$OPTARG
      ;;
    t)
      TIME=$OPTARG
      ;;
    o)
      OUT_FILE=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      usage
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      usage
      ;;
  esac
done

shift $((OPTIND-1))
if [ $# -ne 1 ]; then
  usage
fi

IN_FILE=$1
IN_PATH="file://`pwd`/$IN_FILE"

if [ ! -e $IN_FILE ]; then
  echo "ERROR: Can't find input file \"$IN_FILE\"" >&2
  exit 1
fi

echo "Converting up to $TIME seconds of $IN_PATH at $FPS fps. Output file: $OUT_FILE"

# Note: swapping stdout / stderr to work around ne'er-to-be-fixed PhantomJS bug
(phantomjs $JS_PATH $IN_PATH $TIME $FPS $RES_X $RES_Y 3>&2 2>&1 1>&3-) | ffmpeg -y -c:v png -f image2pipe -r $FPS -t $TIME -i - -c:v libx264 -pix_fmt yuv420p -vf scale=$RES_X:$RES_Y $OUT_FILE
