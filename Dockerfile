FROM osrf/ros:humble-desktop

ENV DEBIAN_FRONTEND=noninteractive
ENV ROS_DISTRO=humble

# Gazebo Fortress is the official default pairing for ROS2 Humble
RUN apt-get update && apt-get install -y \
    ros-humble-ros-gz \
    git \
    build-essential \
    python3-colcon-common-extensions \
    python3-rosdep \
    python3-vcstool \
    mesa-utils \
    && rm -rf /var/lib/apt/lists/*

RUN rosdep init || true && rosdep update

RUN mkdir -p /ros2_ws/src
WORKDIR /ros2_ws/src

RUN git clone https://github.com/LeoRover/leo_simulator-ros2 -b humble
RUN git clone https://github.com/LeoRover/leo_common-ros2 -b ros2

WORKDIR /ros2_ws

RUN apt-get update && \
    /bin/bash -c "source /opt/ros/humble/setup.bash && \
    rosdep install --from-paths src --ignore-src -r -y \
      --skip-keys 'ros-humble-ament-cmake-black ros-humble-ament-cmake-mypy'" && \
    rm -rf /var/lib/apt/lists/*

RUN /bin/bash -c "source /opt/ros/humble/setup.bash && colcon build --symlink-install"

RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc && \
    echo "source /ros2_ws/install/setup.bash" >> ~/.bashrc

CMD ["/bin/bash"]
