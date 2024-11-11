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
Open a web browser and go to http://localhost:8080. You should see the output of your Python application.

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
