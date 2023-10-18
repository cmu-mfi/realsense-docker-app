#!/bin/bash

# Start the first process in the background
# ros2 launch realsense2_camera rs_launch.py

# Start the second process (this will be in the foreground)
ros2 launch aruco_ros single.launch.py markerId:=0 markerSize:=0.1

