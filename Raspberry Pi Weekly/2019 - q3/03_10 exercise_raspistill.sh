#! /bin/bash

# raspistill with no parameters
raspistill $aParameter -a "just plain raspistill" -ae 160 -o raspistill_baseline.jpg

# run the commands that don't require additional parameters
for aParameter in --raw --verbose --vstab --vflip --hflip
do
   theCommand="raspistill $aParameter"
   raspistill $aParameter -a "$theCommand" -ae 160 -o raspistill_$aParameter.jpg
done

# exposure modes
for aParameter in off auto night nightpreview backlight spotlight sports snow beach verylong fixedfps antishake fireworks
do
   theCommand="raspistill --exposure $aParameter"
   raspistill --exposure $aParameter -a "$theCommand" -ae 160 -o raspistill_exposure_$aParameter.jpg
done

# quality
for aParameter in 10 20 30 40 50 60 70 80 90 100
do
   theCommand="raspistill --quality $aParameter"
   raspistill --quality $aParameter -a "$theCommand" -ae 160 -o raspistill_quality_$aParameter.jpg
done

# encoding
for aParameter in jpg bmp gif png
do
   theCommand="raspistill --encoding $aParameter"
   raspistill --encoding $aParameter -a "$theCommand" -ae 160 -o raspistill_encoding.$aParameter
done

# --gl --glscene square teapot mirror yuv sobel vcsm_square
# --gl --glwin <x,y,w,h>
for aParameter in square teapot mirror yuv sobel vcsm_square
do
   theCommand="raspistill --gl --glscene $aParameter"
   raspistill --gl --glscene $aParameter -a "$theCommand" -ae 160 -o raspistill_glscene_$aParameter.jpg
done

# sharpness
for aParameter in -100 -75 -50 -25 0 25 50 75 100
do
   theCommand="raspistill --sharpness $aParameter"
   raspistill --sharpness $aParameter -a "$theCommand" -ae 160 -o raspistill_sharpness_$aParameter.jpg
done

# contrast
for aParameter in -100 -75 -50 -25 0 25 50 75 100
do
   theCommand="raspistill --contrast $aParameter"
   raspistill --contrast $aParameter -a "$theCommand" -ae 160 -o raspistill_contrast_$aParameter.jpg
done

# brightness
for aParameter in 0 25 50 75 100
do
   theCommand="raspistill --brightness $aParameter"
   raspistill --brightness $aParameter -a "$theCommand" -ae 160 -o raspistill_brightness_$aParameter.jpg
done

# saturation
for aParameter in -100 -75 -50 -25 0 25 50 75 100
do
   theCommand="raspistill --saturation $aParameter"
   raspistill --saturation $aParameter -a "$theCommand" -ae 160 -o raspistill_saturation_$aParameter.jpg
done

# ISO
for aParameter in 100 200 300 400 500 600 700 800
do
   theCommand="raspistill --ISO $aParameter"
   raspistill --ISO $aParameter -a "$theCommand" -ae 160 -o raspistill_ISO_$aParameter.jpg
done

# ev compensation (f stop - sort of)
for aParameter in -10 -5 0 5 10
do
   theCommand="raspistill --ev $aParameter"
   raspistill --ev $aParameter -a "$theCommand" -ae 160 -o raspistill_EV_$aParameter.jpg
done

# mode
for aParameter in 0 1 2 3 4 5 6 7
do
   theCommand="raspistill --mode $aParameter"
   raspistill --mode $aParameter -a "$theCommand" -ae 160 -o raspistill_mode_$aParameter.jpg
done

# flicker avoid
for aParameter in off auto 50hz 60hz
do
   theCommand="raspistill --flicker $aParameter"
   raspistill --flicker $aParameter -a "$theCommand" -ae 160 -o raspistill_flicker_$aParameter.jpg
done

# awb
for aParameter in off auto sun cloud shade tungsten fluorescent incandescent flash horizon
do
   theCommand="raspistill --awb $aParameter"
   raspistill --awb $aParameter -a "$theCommand" -ae 160 -o raspistill_awb_$aParameter.jpg
done

# imxfx - image effects
for aParameter in none negative solarise sketch denoise emboss oilpaint hatch gpen pastel watercolour film blur saturation colourswap washedout posterise colourpoint colourbalance cartoon
do
   theCommand="raspistill --imxfx $aParameter"
   raspistill --imxfx $aParameter -a "$theCommand" -ae 160 -o raspistill_glscene_$aParameter.jpg
done

# -cfx, --colfx	: Set colour effect (U:V) range:0 to 255
for aParameter in 0,0 10,255 25,25 128,128 128,200 255,255
do
   theCommand="raspistill --colfx $aParameter"
   fileSuffix="${aParameter/,/_}"
   raspistill --colfx $aParameter -a "$theCommand" -ae 160 -o raspistill_colfx_$fileSuffix.jpg
done

# -mm, --metering	: Set metering mode (see Notes)
for aParameter in average spot backlit matrix
do
   theCommand="raspistill --metering $aParameter"
   raspistill --metering $aParameter -a "$theCommand" -ae 160 -o raspistill_metering_$aParameter.jpg
done

# -rot, --rotation	: Set image rotation (0-359)
# only appears to rotate in 90 degree increments
for aParameter in 0 50 90 180 200 270 359
do
   theCommand="raspistill --rotation $aParameter"
   raspistill --rotation $aParameter -a "$theCommand" -ae 160 -o raspistill_rotation_$aParameter.jpg
done

# -roi, --roi	: Set region of interest (x,y,w,d as normalised coordinates [0.0-1.0])
fileSuffix=0
for aParameter in 0,0,1,1 0.5,0.5,0.25,0.25 0.25,0.5,0.25,0.5
do
   theCommand="raspistill --roi $aParameter"
   ((fileSuffix++))
   raspistill --roi $aParameter -a "$theCommand" -ae 160 -o raspistill_roi_$fileSuffix.jpg
done

# -ss, --shutter	: Set shutter speed in microseconds
for aParameter in 1 50 100 500 1000 5000
do
   theCommand="raspistill --shutter $aParameter"
   raspistill --shutter $aParameter -a "$theCommand" -ae 160 -o raspistill_shutter_$aParameter.jpg
done

# -awbg, --awbgains	: Set AWB gains - AWB mode must be off
fileSuffix=0
for aParameter in 1,1 2,1 1,2 3,3 3,1 1,4 6,1 3,6 8,8
do
   theCommand="raspistill --awbgains $aParameter"
   ((fileSuffix++))
   raspistill --awbgains $aParameter -a "$theCommand" -ae 160 -o raspistill_awbgains_$fileSuffix.jpg
done

# -drc, --drc	: dynamic range compression
for aParameter in off low med high
do
   theCommand="raspistill --drc $aParameter"
   raspistill --drc $aParameter -a "$theCommand" -ae 160 -o raspistill_drc_$aParameter.jpg
done

# stereo
for aParameter in sbs tb off
do
   theCommand="raspistill --stereo $aParameter"
   raspistill --stereo $aParameter -a "$theCommand" -ae 160 -o raspistill_stereo_$aParameter.jpg
done
   raspistill --stereo sbs --decimate -a "stereo sbs decimate" -ae 160 -o raspistill_stereo_decimate.jpg


# -ag, --analoggain	: Set the analog gain (floating point)
for aParameter in 1 2 3 4 5 6 7 8 9 10 11 12
do
   theCommand="raspistill --analoggain $aParameter"
   raspistill --analoggain $aParameter -a "$theCommand" -ae 160 -o raspistill_analoggain_$aParameter.jpg
done

# -dg, --digitalgain	: Set the digital gain (floating point)
for aParameter in 1 2 3 4 5 10 25 50 60
do
   theCommand="raspistill --digitalgain $aParameter"
   raspistill --digitalgain $aParameter -a "$theCommand" -ae 160 -o raspistill_digitalgain_$aParameter.jpg
done

# timelapse photography
# this will produce a capture every two seconds (2000ms),
# over a total period of 30 seconds (30000ms)
raspistill --latest look_here.jpg --timeout 30000 --timelapse 2000 -a "raspistill --timeout 300000 --timelapse 2000" -ae 160 -o raspistill_timelapse_%04d.jpg

# high speed photography
# set timelapse to zero and use burst to suppress preview generation
raspistill --burst --timeout 30000 --timelapse 0 -a "raspistill --burst --timeout 3000 --timelapse 0" -ae 160 -o raspistill_hispeedphoto_%04d.jpg

raspistill --datetime -o raspistill_datetime_%d.jpg

raspistill --timestamp -o raspistill_timestamp_%d.jpg

raspistill --width 100 --height 150 -o raspistill_width_height.jpg

raspistill --framestart 0 raspistill_framestart_%04d.jpg

raspistill --settings 

raspistill > raspistill_manual.txt # produce a manual and store it



# live demo
# --demo --timeout --fullpreview --keypress --signal --camselect --latest --exif
# --gpsdexif requires libgps.so.22
# --preview --fullscreen --opacity --nopreview
# -st, --stats	: Force recomputation of statistics on stills capture pass

# -a, --annotate	: Enable/Set annotate flags or text
# -ae, --annotateex	: Set extra annotation parameters (text size, text colour(hex YUV), bg colour(hex YUV), justify, x, y)
