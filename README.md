# SmartDeviceLink Core Docker
Docker build for [SDL Core](https://github.com/smartdevicelink/sdl_core).

> Currently only supports `master` and `develop` branches

## Getting Started

### Prerequisites

* [Install Docker](https://docs.docker.com/engine/installation/)

### Create a new Docker container
   
   *Master*
   ```bash
   $ docker run -d -P -p 8087:8087 --name Name-of-my-container smartdevicelink/core:latest
   ```
   *Develop*
   ```bash
   $ docker run -d -P -p 8087:8087 --name Name-of-my-container smartdevicelink/core:develop
   ```
   
### Ports
   
Docker automatically creates a port mapping to the following ports in the container:
   
| container port | description                                                 |
|----------------|-------------------------------------------------------------|
| 8087           | Websocket port used by the HMI to communicate with SDL Core |
| 8080           | Serves static web HMI                                       |
| 12345          | SDL Core's primary port                                     |

Docker will automatically map the exposed ports for you when you use the `-P` flag. If the Websocket port `8087` is mapped to anything other than `8087` in the cotainer then you must supply the `HMI_WEBSOCKET_ADDRESS` enviroment vairable when docker is ran. This is required so that the HMI can communicate with Core. For example if you wanted to map port `9001` of your machine to the container's port `8087` then you would set the `HMI_WEBSOCKET_ADDRESS` using the `-e` flag as follows:

```bash
$ docker run -d -P -p 9001:8087 -e "HMI_WEBSOCKET_ADDRESS=127.0.0.1:9001"  --name my-container smartdevicelink/core:latest
```

## Build image from DockerFile
**Note:** SDL Core will take some time to compile

```bash
$ docker build -t my-build-tag .
```
