# test every option for raspivid
# built as part of LinkedIn Learning Raspberry Pi Weekly by Mark Niemann-Ross
# raspivid documentation at https://www.raspberrypi.org/documentation/raspbian/applications/camera.md

# create a commonly used function
# raspivid "mode" "parameter list"
do_raspivid_cmd() {
   for aParameter in $2
   do
      theCommand="raspivid --$1 $aParameter"
      raspivid --nopreview --$1 $aParameter -a "$theCommand" -o raspivid_$1_$aParameter.h264
      echo $theCommand
   done
}


#-b, --bitrate	: Set bitrate. Use bits per second (e.g. 10MBits/s would be -b 10000000)
do_raspivid_cmd "bitrate" "1000000 5000000 10000000 20000000" 

#-t, --timeout	: Time (in ms) to capture for. If not specified, set to 5s. Zero to disable
do_raspivid_cmd "timeout" "5000 10000 20000"

#-d, --demo	: Run a demo mode (cycle through range of camera options, no capture)
# for example, raspivid --demo 300 --timeout 30000

#-fps, --framerate	: Specify the frames per second to record
do_raspivid_cmd "framerate" "24 30 48 50 60"

#-e, --penc	: Display preview image *after* encoding (shows compression artifacts)

#-g, --intra	: Specify the intra refresh period (key frame rate/GoP size). Zero to produce an initial I-frame and then just P-frames.
do_raspivid_cmd "intra" "0 10 50 100"

#-pf, --profile	: Specify H264 profile to use for encoding
do_raspivid_cmd "profile" "baseline main high"

#-td, --timed	: Cycle between capture and pause. -cycle on,off where on is record time and off is pause time in ms
raspivid --timeout 15000 --timed 2500,5000  -a "time=15000 timed=2500,5000" -o raspivid_timed.h264

#-sp, --split	: In wait mode (keypress or signal), create new output file for each start event
#-s, --signal	: Cycle between capture and pause on Signal
#-k, --keypress	: Cycle between capture and pause on ENTER

#-i, --initial	: Initial state. Use 'record' or 'pause'. Default 'record'

#-qp, --qp	: Quantisation parameter. Use approximately 10-40. Default 0 (off)
do_raspivid_cmd "qp" "10 20 30 40"

#-ih, --inline	: Insert inline headers (SPS, PPS) to stream

#-sg, --segment	: Segment output file in to multiple files at specified interval <ms>
raspivid --timeout 15000 --segment 3000  -a "segment = 3000" -o raspivid_timed%04d.h264

#-wr, --wrap	: In segment mode, wrap any numbered filename back to 1 when reach number

#-sn, --start	: In segment mode, start with specified segment number

#-c, --circular	: Run encoded data through circular buffer until triggered then save

#-x, --vectors	: Output filename <filename> for inline motion vectors
raspivid --vectors raspvid_vector_out.h264 -a "vectors" -o raspivid_vectors.h264

#-if, --irefresh	: Set intra refresh type
do_raspivid_cmd "irefresh" "cyclic adaptive both cyclicrows"

#-fl, --flush	: Flush buffers in order to decrease latency

#-pts, --save-pts	: Save Timestamps to file for mkvmerge
do_raspivid_cmd "" ""
raspivid --save-pts raspvid_save-pts_out.h264 -a "save-pts" -o raspivid_save-pts.h264

#-cd, --codec	: Specify the codec to use - H264 (default) or MJPEG
do_raspivid_cmd "codec" "H264 MJPEG"

#-lev, --level	: Specify H264 level to use for encoding
do_raspivid_cmd "level" "4 4.1 4.2"


#-r, --raw	: Output filename <filename> for raw video
#-rf, --raw-format	: Specify output format for raw video. Default is yuv
for aParameter in yuv rgb gray
do
   theCommand="raspivid --raw  $aParameter"
   raspivid --raw-format $aParameter -a "$theCommand" --raw raspivid_raw_$aParameter.h264
   echo $theCommand
done

#-stm, --spstimings	: Add in h.264 sps timings

#-sl, --slices	: Horizontal slices per frame. Default 1 (off)
do_raspivid_cmd "slices" "1 10 100"


#Raspivid allows output to a remote IPv4 host e.g. -o tcp://192.168.1.2:1234or -o udp://192.168.1.2:1234
#To listen on a TCP port (IPv4) and wait for an incoming connection use the -l option
#e.g. raspivid -l -o tcp://0.0.0.0:3333 -> bind to all network interfaces,
#raspivid -l -o tcp://192.168.1.1:3333 -> bind to a certain local IPv4 port

#-l, --listen	: Listen on a TCP socket

#Common Settings commands

#-?, --help	: This help information
#-w, --width	: Set image width <size>
do_raspivid_cmd "width" "100 1000 2000"

#-h, --height	: Set image height <size>
do_raspivid_cmd "height" "100 1000 2000"

#-o, --output	: Output filename <filename> (to write to stdout, use '-o -'). If not specified, no file is saved
#-v, --verbose	: Output verbose information during run

#-cs, --camselect	: Select camera <number>. Default 0
#-md, --mode	: Force sensor mode. 0=auto. See docs for other modes available
do_raspivid_cmd "mode" "0 1 2 3 4 5 6 7"

#-gps, --gpsdexif	: Apply real-time GPS information to output (e.g. EXIF in JPG, annotation in video (requires libgps.so.22)

#Preview parameter commands

#-p, --preview	: Preview window settings <'x,y,w,h'>
raspivid --preview 100,100,300,300

#-f, --fullscreen	: Fullscreen preview mode
raspivid --fullscreen

#-op, --opacity	: Preview window opacity (0-255)
raspivid --opacity 200

#-n, --nopreview	: Do not display a preview window
raspivid --nopreview

#Image parameter commands

#-sh, --sharpness	: Set image sharpness (-100 to 100)
do_raspivid_cmd "sharpness" "-100 -50 -25 0 25 50 100"

#-co, --contrast	: Set image contrast (-100 to 100)
do_raspivid_cmd "contrast" "-100 -50 -25 0 25 50 100"

#-br, --brightness	: Set image brightness (0 to 100)
do_raspivid_cmd "brightness" "0 25 50 100"

#-sa, --saturation	: Set image saturation (-100 to 100)
do_raspivid_cmd "saturation" "-100 -50 -25 0 25 50 100"

#-ISO, --ISO	: Set capture ISO
do_raspivid_cmd "ISO" "100 200 300 400 500 600 700 800"

#-vs, --vstab	: Turn on video stabilisation
do_raspivid_cmd "vstab" ""

#-ev, --ev	: Set EV compensation - steps of 1/6 stop
do_raspivid_cmd "ev" "-10 -5 0 5 10"

#-ex, --exposure	: Set exposure mode 
do_raspivid_cmd "exposure" "off auto night nightpreview backlight spotlight sports snow beach verylong fixedfps antishake fireworks"

#-fli, --flicker	: Set flicker avoid mode 
do_raspivid_cmd "flicker" "off auto 50hz 60hz"

#-awb, --awb	: Set AWB mode 
do_raspivid_cmd "awb" "off auto sun cloud shade tungsten fluorescent incandescent flash horizon"

#-awbg, --awbgains	: Set AWB gains - AWB mode must be off
for aParameter in 1.5,1.2 1,1 1,2
do
   theCommand="raspivid --awbgains $aParameter"
   raspivid --awb off --awbgains $aParameter -a "$theCommand" -o raspivid_awbgains_%04d.h264
   echo $theCommand
done

#-ifx, --imxfx	: Set image effect
do_raspivid_cmd "imxfx" "none negative solarise sketch denoise emboss oilpaint hatch gpen pastel watercolour film blur saturation colourswap washedout posterise colourpoint colourbalance cartoon"

#-cfx, --colfx	: Set colour effect (U:V)
do_raspivid_cmd "colfx" "0:255 128:255 128:128 255:128 255:0"

#-mm, --metering	: Set metering mode
do_raspivid_cmd "metering" "average spot backlit matrix"

#-rot, --rotation	: Set image rotation (0-359)
do_raspivid_cmd "rotation" "0 30 90 180 270"

#-hf, --hflip	: Set horizontal flip
do_raspivid_cmd "hflip" " "

#-vf, --vflip	: Set vertical flip
do_raspivid_cmd "vflip" " "

#-roi, --roi	: Set region of interest (x,y,w,d as normalised coordinates [0.0-1.0])
do_raspivid_cmd "roi" "0.5,0.5,0.25,0.25 0,0,0.25,0.25 0.75,0.75,0.25,0.25"

#-ss, --shutter	: Set shutter speed in microseconds
do_raspivid_cmd "shutter" "1 10 100 1000"

#-drc, --drc	: Set DRC Level (Dynamic Range)
do_raspivid_cmd "drc" "off low med high"

#-st, --stats	: Force recomputation of statistics on stills capture pass

#-a, --annotate	: Enable/Set annotate flags or text
#-ae, --annotateex	: Set extra annotation parameters (text size, text colour(hex YUV), bg colour(hex YUV), justify, x, y)

#-3d, --stereo	: Select stereoscopic mode
do_raspivid_cmd "stereo" "sbs tb off"

#-dec, --decimate	: Half width/height of stereo image
raspivid --decimate --stereo sbs -a "decimate stereo sbs" -o raspivid_stereo_decimate.h264

#-3dswap, --3dswap	: Swap camera order for stereoscopic
# currently not working

#-ag, --analoggain	: Set the analog gain (floating point)
do_raspivid_cmd "analoggain" "1 2 4 8 12"

#-dg, --digitalgain	: Set the digital gain (floating point)
do_raspivid_cmd "digitalgain" "1 2 3 4 10"

#-set, --settings	: Retrieve camera settings and write to stdout


