#!/bin/sh

#-vf "lutyuv=y=val*1.3" \
ffmpeg -i ~/Desktop/foobar6.mp4 \
   -s 700x570 -pix_fmt rgb24 \
   -vf crop=1326:1080:297:0 \
   -r 10 -f gif - \
   | gifsicle --colors=16 --optimize=3 --delay=3  > demo.gif
