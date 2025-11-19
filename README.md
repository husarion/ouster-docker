# ouster-docker

Dockerized Ouster LiDAR package from [ouster-lidar/ouster-ros](https://github.com/ouster-lidar/ouster-ros) repository.

## Ouster factory settings

By default, the LIDAR obtains its IP address from the router’s DHCP server. It is also accessible on the local network via mDNS. To open the Ouster configuration panel, enter the following address in your browser:

```
http://os-123456789101.local
```

Replace `123456789101` with your LIDAR’s serial number.

In the web interface you can check the current IP address, but setting a static IP must be done via the HTTP API (this option is not available in the web UI).

To assign a static IPv4 address, use one of the following commands:

1. Using the current IPv4 address:

```bash
curl -i -X PUT http://x.x.x.x/api/v1/system/network/ipv4/override -H 'Content-Type: application/json' --data-raw '"y.y.y.y/24"'
```

2. Using mDNS:

```bash
curl -i -X PUT http://os-123456789101.local/api/v1/system/network/ipv4/override -H 'Content-Type: application/json' --data-raw '"y.y.y.y/24"'
```

Read more [here](https://community.ouster.com/t/how-to-set-a-static-ip-via-curl/44)


## Running a Docker container

```bash
docker run --rm -it \
  husarion/ouster:humble-0.10.2-20230831 \
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

