# wformat

wformat is a command line utility to organize collections of wallpapers

For now, it can only reformat images into proper sizes(for dualmonitors
too)

Soon it will feature organization through renaming and the ability to 
search for duplicates of images

## Usage

### Merging Images

Create a merged image:

`wformat merge [IMAGE_ONE] [IMAGE_TWO]`

The default expected dual monitor screen is actually 1920x1200. Change
that using options

`wformat merge --widthone=1600 --heightone=1200 --widthtwo=800
--heighttwo=600 [IMAGE_ONE] [IMAGE_TWO]`

Or give the merge your own output filename

`wformat merge --title="turtles.jpg" [IMAGE_ONE] [IMAGE_TWO]`

### Scaling images

Create a scaled image:

`wformat scale [IMAGE_ONE]`

The default expected monitor screen is actually 1920x1200. Change
that using options

`wformat scale --width=1600 --height=1200 [IMAGE]`

Or give the scaled result your own output filename

`wformat scale --title="turtles.jpg" [IMAGE]`

## Dependencies

RMagick(https://rubygems.org/gems/rmagick)

On ubuntu, install ImageMagick dependencies for RMagick:

`sudo apt-get install imagemagick libmagick9-dev`
