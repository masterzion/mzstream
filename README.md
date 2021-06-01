# mzstream

Transmit video and audio from the capture card + camera video to the twitch

# Output Result

![Screenshot](https://github.com/masterzion/mzstream/blob/main/Screenshot.png)

More details at: https://youtu.be/7Jj2e0VOGfw

# Configure

Open your bashrc file 

```
nano ~/.bashrc
```

Add at the end your TWITCH secret
You cand find yours at https://dashboard.twitch.tv/settings/stream

```
export TWITCH_KEY=YOUR_SECRET_KEY
```

# Content

| Scripts              | Function                              |
|----------------------|:-------------------------------------:|
| installdeps.sh       | Install all dependences               |
| build.sh             | Download and build FFMPEG on raspberry|
| build_ubuntux64.sh   | Download and build FFMPEG on Ubuntu   |
| listinterfaces.sh    | list all available interface          |
| mzstream.sh          | Main program                          |
| README.md            | This file  :)                         |


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

Check the "Recommended Ingest Endpoints For You"
https://stream.twitch.tv/ingests/

# Trasmitting

./mzstream.sh VIDEOCARD WEBCAM AUDIO_DEVICE INGEST_ENDPOINT

```
./mzstream.sh /dev/video2 /dev/video4 1 rtmp://waw.contribute.live-video.net/app/

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


![Hardware](https://github.com/masterzion/mzstream/blob/main/hardware.jpg)


# License

GNU General Public License (GPL) version 2


# Important

I won't take responsibility of anything
Use by your own risk
