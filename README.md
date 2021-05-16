# mzstream

Transmmit video capture video and audio + camera video  to twitch




# mzstream

Open your bashrc file 

```
nano ~/.bashrc
```

add at the end your TWITCH secret

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


Trasmitting

```
./mzstream.sh /dev/video0 /dev/video2 1
```



# Todo

WEB UI


# License

GNU General Public License (GPL) version 2
