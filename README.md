# SmartDeviceLink Core Docker
Docker build for [SDL Core](https://github.com/smartdevicelink/sdl_core).

> Currently only supports `master` and `develop` branches

## Getting Started

### Prerequisites

* [Install Docker > 1.8](https://docs.docker.com/engine/installation/)

### Create a new Docker container
   
   *Master*
   ```bash
   $ docker run -d -p 12345:12345 -p 8080:8080 -p 8087:8087 -p 3001:3001 --name core smartdevicelink/core:latest
   ```
   *Develop*
   ```bash
   $ docker run -d -p 12345:12345 -p 8080:8080 -p 8087:8087 -p 3001:3001 --name core smartdevicelink/core:develop
   ```
   
### Ports
   
Docker automatically creates a port mapping to the following ports in the container:
   
| container port | description                                                 |
|----------------|-------------------------------------------------------------|
| 3001           | Port exposing core's file system                            |        
| 8087           | Websocket port used by the HMI to communicate with SDL Core |
| 8080           | Serves static web HMI                                       |
| 12345          | SDL Core's primary port                                     |

Docker will automatically map the exposed ports for you when you use the `-P` flag. If the Websocket port `8087` is mapped to anything other than `8087` in the container then you must supply the `HMI_WEBSOCKET_ADDRESS` enviroment variable when Docker is ran. This is required so that the HMI can communicate with Core. For example if you wanted to map port `9001` of your machine to the container's port `8087` then you would set the `HMI_WEBSOCKET_ADDRESS` using the `-e` flag as follows:

```bash
$ docker run -d -P -p 9001:8087 -e "HMI_WEBSOCKET_ADDRESS=127.0.0.1:9001"  --name core smartdevicelink/core:latest
```

## Accessing SDL Core's files remotely

Typically SDL Core and its corresponding HMI exist on the same machine. For development this is not always the case. In the Docker image there is an NGINX server that exposes the contents of the storage folder `/usr/sdl/bin/storage` over port `3001`. These contents can be access using the absolute path as it existis on the core machine. For example if core is running on your local machine, a SetAppIcon request would respond with the value `/usr/sdl/bin/storage/SyncProxyTester584421907/icon.png`. The server on port `3001` can be used to access this file remotely: `http://localhost:3001/usr/sdl/bin/storage/SyncProxyTester584421907/icon.png/`

## Build image from DockerFile
**Note:** SDL Core will take some time to compile

```bash
$ docker build -t my-build-tag .
```

## TODO

* Set-up automated builds and tags based on SDL_Core repository
