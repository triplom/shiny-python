# Running Shiny for Python apps in ShinyProxy

This repository describes how to add a Shiny for Python app inside ShinyProxy.

## Build the Docker image

To pull the image made in this repository from Docker Hub, use

```bash
docker pull openanalytics/shinyproxy-shiny-for-python-demo
```

the relevant Docker Hub repository can be found at [https://hub.docker.com/r/openanalytics/shinyproxy-shiny-for-python-demo](https://hub.docker.com/r/openanalytics/shinyproxy-shiny-for-python-demo)

To build the image from the Dockerfile, clone this repository, then navigate to its root directory and run

```bash
docker build -t openanalytics/shinyproxy-shiny-for-python-demo .
```

## Run the application

To check and validate if the application works, you can follow these steps:

Run the Docker container:

```bash
docker run -p 8080:8080  openanalytics/shinyproxy-shiny-for-python-demo
```

This will start the container and map port 8080 on the host to port 8080 in the container.

Verify the application is running:
Open a web browser and go to [http://localhost:8080](http://localhost:8080). You should see the output of your Python application.

Alternatively, you can use a tool like curl to make a request to the application:

```bash
curl http://localhost:8080
```

This should return the response from your Python application.

Check the container logs:
You can check the logs of the running container to see any output or errors:

docker logs <container_id>
Replace <container_id> with the actual ID or name of the running container.

By following these steps, you can verify that the Docker image was built correctly and the Python application is running as expected inside the container. This will help you ensure the application is working as intended before deploying it to a production environment.

## Alternatively, run with Docker-compose

To use this Docker Compose file, save it as docker-compose.yml in the same directory as your Dockerfile and app.py file.

Then, you can start the application using the following command:

```bash
docker-compose up -d
```

This will build the Docker image, if it doesn't already exist, and start the container in detached mode (-d).

Once the container is running, you can access the application at [http://localhost:8080](http://localhost:8080).

The advantage of using Docker Compose is that it simplifies the process of managing multiple containers and their dependencies. It also allows you to easily scale your application by adding more services or instances of the same service.

## ShinyProxy Configuration

To add the Shiny For Python application to ShinyProxy add the following lines to its configuration file (see [application.yaml](./application.yaml) for a complete file):

```yaml
proxy:
  specs:
    - id: shiny-for-python-demo
      display-name: Shiny For Python Demo Application
      container-image: openanalytics/shinyproxy-shiny-for-python-demo
      port: 8080
```

## References

* [Shiny for Python Documentation](https://shiny.posit.co/py/docs/overview.html)
* [Matplotlib Interactive Adjustment](https://matplotlib.org/3.5.3/gallery/userdemo/colormap_interactive_adjustment.html)

**(c) Copyright Open Analytics NV, 2023.**
