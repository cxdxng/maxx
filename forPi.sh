#!/bin/bash/
flutter build bundle
scp -r ./build/flutter_assets/ pi@raspberrypi:/home/pi/maxX

