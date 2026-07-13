# Leo Rover Simulation — Docker Setup

ROS2 Humble + Gazebo Fortress + Leo Rover, containerized with native NVIDIA GPU passthrough.

## Prerequisites (on the host)
- Ubuntu 22.04, native (not WSL)
- NVIDIA driver installed (`nvidia-smi` should work)
- Docker Engine installed
- NVIDIA Container Toolkit installed and configured (`nvidia-ctk runtime configure --runtime=docker`)

## Usage
```bash
./start-leo-rover.sh
```
This builds/enters the container. Inside:
```bash
ros2 launch leo_gz_bringup leo_gz.launch.py
```

## Notes
- `xhost +local:docker` runs automatically in the launch script to allow the container to connect to the host's X display.
- GPU flags (`NVIDIA_DRIVER_CAPABILITIES`, `__NV_PRIME_RENDER_OFFLOAD`, `__GLX_VENDOR_LIBRARY_NAME`) are needed specifically for hybrid-graphics laptops (integrated + discrete GPU).
