# SVG2MP4

## What is it?

A wrapper that uses PhantomJS and FFmpeg to take an animated SVG file and convert it to an MP4 with a few parameters.

Also included is a similar PhantomJS script (`svg-to-png.js`) that creates a numbered PNG sequence which you can important into a video editor or whatnot.

## Why would you want this?

I wanted to use LibreOffice Impress to generate animated text and diagrams for use in videos. Impress can export animated SVG but my video editor of choice, Blender VSE, only imports raster video formats.

"Inspired" by:
* This [StackOverflow question](https://stackoverflow.com/questions/19759138/error-using-ffmpeg-image2pipe-with-phantomjs-to-render-video-from-webpage-screen)
* [Recording a website with PhantomJS and FFmpeg](https://mindthecode.com/recording-a-website-with-phantomjs-and-ffmpeg/)

## License
zlib
___
## TODO

* [ ] Reduce PNG compression to make frame export faster
* [ ] Other FFmpeg options?
