# Use the latest version of the Debian image as the base
FROM debian:latest

# Update the package lists and upgrade all installed packages to their latest versions
RUN apt update && apt upgrade -y

# Install necessary packages and libraries
RUN apt install -y git libirrlicht* libeigen3* cmake-curses-gui g++ libxxf86vm* freeglut3* libx11-dev* libgl1-mesa-dev nano \
tk-dev tcl-dev libfreetype6-dev libxmu-dev libxi-dev


RUN git clone https://git.dev.opencascade.org/repos/occt.git occt --recurse-submodules

WORKDIR /occt
RUN git checkout V7_4_0
RUN mkdir build
RUN cd build && cmake -S .. -B . && make && make install

WORKDIR /


# Clone the Chrono project repository from GitHub
RUN git clone https://github.com/projectchrono/chrono.git

RUN cd chrono && mkdir build


# Set the working directory to the build directory
WORKDIR /chrono/build 

# Configure the project with CMake, enabling specific modules and setting the build type to Release
RUN cmake -S .. -B . -DENABLE_MODULE_IRRLICHT=ON -DENABLE_MODULE_POSTPROCESS=ON -DENABLE_MODULE_CASCADE=ON -DCMAKE_BUILD_TYPE=Release

# Compile the project and install it
RUN make && make install 

# Update the shared library cache
RUN ldconfig
