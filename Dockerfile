# syntax=docker/dockerfile:1

FROM osrf/ros:humble-desktop

COPY run_launches.py /root/run_launches.py
COPY aruco_ros /root/ros2_ws/src/aruco_ros/

RUN useradd -ms /bin/bash admin
RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc

RUN apt-get update \
    && apt-get install -y curl \
    && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - \
    && apt-get update \
    && apt install -y ros-humble-librealsense2* \
    && apt install -y ros-humble-realsense2-* \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt install -y software-properties-common \
    && add-apt-repository -y ppa:borglab/gtsam-release-4.1 \
    && apt-get update \
    && apt install -y libgtsam-dev libgtsam-unstable-dev \
    && apt-get install tmux -y \
    && apt install swig -y \
    && apt install vim -y \
    && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-c"]

RUN cd /root/ros2_ws \
    && source /opt/ros/humble/setup.bash \
    && colcon build
RUN echo "source /root/ros2_ws/install/local_setup.bash" >> /root/.bashrc 

WORKDIR /root/
USER root