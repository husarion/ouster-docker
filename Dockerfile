ARG ROS_DISTRO=melodic

FROM ros:${ROS_DISTRO}-ros-core

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    curl \
    debhelper \
    dpkg-dev \
    fakeroot \
    python-bloom \
    python-rosdep \
    python-rospkg 

WORKDIR /ros_ws

RUN git clone --recurse-submodules https://github.com/ouster-lidar/ouster-ros.git src/ouster-ros

# RUN apt-get update && \
RUN rosdep init && \
    rosdep update --rosdistro=$ROS_DISTRO && \
    rosdep install -y --from-paths src && \
    source /opt/ros/$ROS_DISTRO/setup.bash && \
    catkin_make -DCATKIN_ENABLE_TESTING=0 -DCMAKE_BUILD_TYPE=Release

COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["bash"]