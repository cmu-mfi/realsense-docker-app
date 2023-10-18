#!/usr/bin/env python3

import subprocess
import time

def main():
    # Start the ROS 2 daemon
    daemon_process = subprocess.Popen(['ros2', 'daemon', 'start'])

    # Wait for a moment to ensure the daemon has started
    time.sleep(2)

    # Start the realsense_camera launch
    realsense_process = subprocess.Popen(['ros2', 'launch', 'realsense2_camera', 'rs_launch.py'])

    # Wait for 1 second
    time.sleep(1)

    # Define the parameters you want to pass
    params = ['markerID:=0', 'markerSize:=0.1']

    # Start the aruco_ros launch with parameters
    aruco_process = subprocess.Popen(['ros2', 'launch', 'aruco_ros', 'single.launch.py'] + params)

    try:
        # Keep the script running to maintain the child processes
        realsense_process.wait()
        aruco_process.wait()
    except KeyboardInterrupt:
        # If interrupted, terminate the child processes
        realsense_process.terminate()
        aruco_process.terminate()

    # Stop the ROS 2 daemon when finished
    daemon_process.terminate()

if __name__ == '__main__':
    main()
