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




# # INSTALL DEPENDENCIES FOR VELODYNE PACKAGE
# RUN apt-get install -y libpcap-dev


# RUN apt-get update \
#     && apt-get install -y curl \
#     && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - \
#     && apt-get update \
#     && apt install -y python3-colcon-common-extensions \
#     && apt-get install -y ros-humble-navigation2 \
#     && apt-get install -y ros-humble-robot-localization \
#     && apt-get install -y ros-humble-robot-state-publisher \
#     && apt install -y ros-humble-perception-pcl \
#   	&& apt install -y ros-humble-pcl-msgs \
#   	&& apt install -y ros-humble-vision-opencv \
#   	&& apt install -y ros-humble-xacro \
#     && apt install -y nano gedit \
#     && rm -rf /var/lib/apt/lists/*

# RUN apt-get update \
#     && apt install -y software-properties-common \
#     && add-apt-repository -y ppa:borglab/gtsam-release-4.1 \
#     && apt-get update \
#     && apt install -y libgtsam-dev libgtsam-unstable-dev \
#     && rm -rf /var/lib/apt/lists/*

# SHELL ["/bin/bash", "-c"]

# RUN mkdir -p ~/ros2_ws/src \
#     && cd ~/ros2_ws/src \
#     && git clone --branch ros2 https://github.com/enescingoz/LIO-SAM


# RUN cd ~/ros2_ws/src \
#     && git clone --branch humble-devel https://github.com/ros-drivers/velodyne.git
#     # && cd .. \
#     # && source /opt/ros/humble/setup.bash \
#     # && colcon build


# RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc \
#     && echo "source /root/ros2_ws/install/setup.bash" >> /root/.bashrc

# WORKDIR /root/ros2_ws
