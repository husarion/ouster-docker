# ouster-docker

Dockerized Ouster LiDAR package from [ouster-lidar/ouster-ros](https://github.com/ouster-lidar/ouster-ros) repository.

## Running a Docker container

```bash
docker run --rm -it \
  husarion/ouster:humble \
  ros2 launch ouster_ros sensor.composite.launch.xml \
    timestamp_mode:=TIME_FROM_ROS_TIME \
    metadata:=/ouster_metadata.json \
    sensor_hostname:=10.15.20.5 \
    lidar_mode:=1024x20 
```

## ROS node

For more information about the Ouster ROS package itself, please refer to [README.md](https://github.com/ouster-lidar/ouster-ros#readme)

## Demo

### Ouster LiDAR container + rviz container

Connect Ouster LiDAR to the first computer and run:
```bash
git clone https://github.com/husarion/ouster-docker.git
cd ouster-docker/demo

docker compose \
-f compose.ouster.yaml \
up
```

On the second computer connected to the same LAN and run:
```bash
git clone https://github.com/husarion/ouster-docker.git
cd ouster-docker/demo

docker compose \
-f compose.rviz.yaml \
up
```

