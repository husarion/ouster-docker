# ouster-docker

Dockerized Ouster LiDAR package from [ouster-lidar/ouster_example](https://github.com/ouster-lidar/ouster_example) repository.

## Time synchronizing

Before launching the Ouster ROS driver, the Precision Time Protocol (PTP) should be configured on the host computer.

```bash
sudo ptp4l -i eno1 -m [global] tx_timestamp_timeout 10
```

## Running a Docker container

```bash
docker run --rm -it \
  husarion/ouster:melodic \
  roslaunch ouster_ros ouster.launch \
    sensor_hostname:=10.15.20.5 \
    timestamp_mode:=TIME_FROM_PTP_1588 \
    lidar_mode:=512x10 metadata:=/ouster_metadata.json
```

## ROS node

For more information about the Ouster ROS package itself, please refer to [README.md](https://github.com/ouster-lidar/ouster_example/blob/master/README.rst)

## Demo

### Ouster LiDAR container + rviz container

Connect Ouster LiDAR to the first computer and run:

```bash
cd demo
docker compose -f compose.ouster.yaml up
```

On the second computer (or the first one) with a connected display run:

```bash
cd demo
xhost local:root
docker compose -f compose.rviz.yaml up
```
