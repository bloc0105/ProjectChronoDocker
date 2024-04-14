FROM debian:latest
RUN apt update && apt upgrade -y
RUN apt install -y git libirrlicht* libeigen3* cmake-curses-gui g++ libxxf86vm* freeglut3* libx11-dev* libgl1-mesa-dev nano
RUN git clone https://github.com/projectchrono/chrono.git
RUN cd chrono && mkdir build
WORKDIR /chrono/build 
RUN cmake -S .. -B . -DENABLE_MODULE_IRRLICHT=ON -DENABLE_MODULE_POSTPROCESS=ON -DCMAKE_BUILD_TYPE=Release
RUN make && make install 
RUN ldconfig
