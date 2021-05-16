cd 
git clone -b release/4.4 https://github.com/FFmpeg/FFmpeg.git
cd FFmpeg
./configure --extra-ldflags="-latomic" --target-os=linux --enable-gpl --enable-omx --enable-omx-rpi --enable-nonfree \
         --enable-libmp3lame \
        --enable-librtmp \
        --enable-version3 \
        --target-os=linux \
        --enable-pthreads \
        --enable-mmal \
        --enable-libx264 \
        --enable-libx265 \
        --enable-libxml2 
make
sudo make install

