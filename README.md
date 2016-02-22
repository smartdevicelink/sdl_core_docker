# SmartDeviceLink Core Docker
Docker build for [SDL Core](https://github.com/smartdevicelink/sdl_core).

> Currently only supports `master` and `develop` branches

## Getting Started

### Prerequisites

* [Install Docker](https://docs.docker.com/engine/installation/)

### Create a new Docker container
   
   *Master*
   ```bash
   $ docker run -d -P --name Name-of-my-container SmartDeviceLink/Core:latest
   ```
   *Develop*
   ```bash
   $ docker run -d -P --name Name-of-my-container SmartDeviceLink/Core:develop
   ```
### Access HMI by figure out which port it was automatically assigned.
   
Docker automatically creates a port mapping to the following ports in the container:
   
| container port | description                                                 |
|----------------|-------------------------------------------------------------|
| 8087           | Websocket port used by the HMI to communicate with SDL Core |
| 8080           | Serves static web HMI                                       |
| 12345          | SDL Core's primary port                                     |

In order to access the HMI we need to figure out which dynamic port is mapped to port `8087` of the container.

```bash
$ docker ps
```

Then find the port that is mapped to `8087` it should look like `0.0.0.0:36789->8087/tcp`. Access the HMI by going to `http://x.x.x.x:36789` 

## Build image from DockerFile
**Note:** SDL Core will take some time to compile

```bash
$ docker build -t my-build-tag .
```
