#!/usr/bin/env bash

# Set display configuration
xrandr --output HDMI-1 --mode 1920x1080 --rate 144 --primary --right-of HDMI-0 \
       --output HDMI-0 --mode 1920x1080 --rate 75
