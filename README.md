# mzstream

Transmit video and audio from the capture card + camera video to the twitch

# WebUI

![Screenshot](https://github.com/masterzion/mzstream/blob/main/docs/webui.png)

# Output Result

![Screenshot](https://github.com/masterzion/mzstream/blob/main/docs/Screenshot.png)

More details at: https://youtu.be/7Jj2e0VOGfw

# Configure

Create a configuration file in your home direcotry ~/.mzstream 

```
nano ~/.mzstream
```

Add at the end your TWITCH secret
You can find yours at https://dashboard.twitch.tv/settings/stream

Check the "Recommended Ingest Endpoints For You" for the right TWITCH_URL value
https://stream.twitch.tv/ingests/

```
export TWITCH_KEY=YOUR_SECRET_KEY
export WEBUI_PORT=8777
export TWITCH_URL=rtmp://waw.contribute.live-video.net/app/
```

# Content

| Scripts              | Function                              |
|----------------------|:-------------------------------------:|
| README.md            | This file  :)                         |
| installdeps.sh       | Install all dependences               |
| build.sh             | Download and build FFMPEG on raspberry|
| build_ubuntux64.sh   | Download and build FFMPEG on Ubuntu   |
| listinterfaces.sh    | list all available interface          |
| mzstream.sh          | Main program                          |
| install_web.sh       | Install and uninstall the webservice  |
| http.py              | Light http server (python2)           |
| docs/                | Documentation images                  |
| web/                 | files for the  webservice             |




# Install

Install this script and builf the new ffmpeg

```
git clone https://github.com/masterzion/mzstream.git
cd mzstream
./installdeps.sh
./build.sh
```

# Running

List the interfaces

```
./listinterfaces.sh
```

# manual run

./mzstream.sh VIDEOCARD WEBCAM AUDIO_DEVICE POS_X_PERCENT POS_Y_PERCENT INGEST_ENDPOINT

```
./mzstream.sh /dev/video2 /dev/video4 1 98 98 rtmp://waw.contribute.live-video.net/app/

```

# install webservice


```
./install_web.sh

```

# uninstall webservice

```
./install_web.sh --uninstall

```




# Todo
 - WEB UI
 - Improve performance

# Overclock

https://magpi.raspberrypi.org/articles/how-to-overclock-raspberry-pi-4

# Hardware

 - Raspberry pi 4
 - Aluminum Aluminum Case - https://www.aliexpress.com/item/4000204565326.html
 - ezcap
 - Razer Kiyo


![Hardware](https://github.com/masterzion/mzstream/blob/main/docs/hardware.jpg)


# License

GNU General Public License (GPL) version 2


# Important

I won't take responsibility of anything
Use by your own risk
