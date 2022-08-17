ARG ROS_DISTRO=melodic

FROM ros:${ROS_DISTRO}-ros-core

SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND=noninteractive \
    BUILD_HOME=/ros_ws \
    OUSTER_SDK_PATH=/opt/ouster_example

# Kinetic and melodic have python3 packages but they seem to conflict
RUN [ $ROS_DISTRO = "noetic" ] && PY=python3 || PY=python && \
    # Turn off installing extra packages globally to slim down rosdep install
    echo 'APT::Install-Recommends "0";' > /etc/apt/apt.conf.d/01norecommend && \
    apt-get update && apt-get install -y \
        git \
        build-essential cmake \
        fakeroot dpkg-dev debhelper \
        $PY-rosdep $PY-rospkg $PY-bloom \
        linuxptp \
        ros-melodic-tf && \
    git clone https://github.com/ouster-lidar/ouster_example.git ${OUSTER_SDK_PATH}

RUN apt-get update && \
    rosdep init && \
    rosdep update --rosdistro=${ROS_DISTRO} && \
    rosdep install -y --from-paths ${OUSTER_SDK_PATH}

WORKDIR ${BUILD_HOME}

RUN mkdir src && \
    ln -s ${OUSTER_SDK_PATH} ./src

RUN /opt/ros/${ROS_DISTRO}/env.sh catkin_make -DCMAKE_BUILD_TYPE=Release

COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["bash"]