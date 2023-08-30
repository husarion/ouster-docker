ARG ROS_DISTRO=humble

FROM husarnet/ros:${ROS_DISTRO}-ros-core

# select bash as default shell
SHELL ["/bin/bash", "-c"]

WORKDIR /ros2_ws

# install everything needed
RUN apt-get update && apt-get install -y \
        python3-pip \
        python3-colcon-common-extensions \
        python3-rosdep \
        python3-vcstool \
        git && \
    apt-get upgrade -y && \
    source "/opt/ros/$ROS_DISTRO/setup.bash" && \
    git clone -b ros2 --recurse-submodules https://github.com/ouster-lidar/ouster-ros.git /ros2_ws/src/ouster-ros && \
    rm -rf /etc/ros/rosdep/sources.list.d/20-default.list && \
    rosdep init && \
    rosdep update --rosdistro $ROS_DISTRO && \
    rosdep install -i --from-path /ros2_ws/src --rosdistro $ROS_DISTRO -y && \
    colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release && \
    export SUDO_FORCE_REMOVE=yes && \
    apt-get remove -y \
        python3-colcon-common-extensions \
        python3-rosdep \
        python3-vcstool \
        git && \       
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo $(cat /ros2_ws/src/ouster-ros/ouster-ros/package.xml | grep '<version>' | sed -r 's/.*<version>([0-9]+.[0-9]+.[0-9]+)<\/version>/\1/g') > /version.txt