#!/bin/bash

# fake X since diffpdf requires a GUI
Xvfb :1 -screen 0 1024x768x16 &
#             PDF files:  old new output
DISPLAY=:1.0 /root/diffpdf-2.1.3/diffpdf $@