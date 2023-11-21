FROM osrf/ros:noetic-desktop-full
ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update && apt-get upgrade -y

# DEPENDENCIES FOR hdl_graph_slam
RUN apt-get install wget -y \
    wget nano build-essential libomp-dev clang lld git \
    ros-noetic-geodesy ros-noetic-pcl-ros ros-noetic-nmea-msgs \
    ros-noetic-rviz ros-noetic-tf-conversions ros-noetic-libg2o \
    && apt install -y nano gedit \
    && apt-get install -y python3-catkin-tools \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


SHELL ["/bin/bash", "-c"]


# SETUP WORKSPACE
RUN mkdir -p ~/ros_ws/src \
    && cd ~/ros_ws/src \
    && git clone https://github.com/koide3/ndt_omp.git -b melodic \
    && git clone https://github.com/SMRT-AIST/fast_gicp.git --recursive \
    && git clone https://github.com/enescingoz/hdl_graph_slam.git \
    && cd .. \
    && source /opt/ros/noetic/setup.bash \
    && catkin build -DCMAKE_BUILD_TYPE=Release


# SOURCE WORKSPACE
RUN echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc \
    && echo "source /root/ros_ws/devel/setup.bash" >> /root/.bashrc

WORKDIR /root/ros_ws