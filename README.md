
# Running Shiny for Python Apps in ShinyProxy

This guide explains how to create a Shiny for Python app and deploy it with [ShinyProxy](https://www.shinyproxy.io/), an open-source platform for hosting Shiny applications.

## Prerequisites

To follow this guide, ensure you have:

- Basic knowledge of Python and Docker.
- Installed **Docker** and **Docker Compose**.
- Access to **ShinyProxy** (self-hosted or managed environment).

## 1. Building a Shiny for Python App

Shiny for Python, developed by [Posit](https://shiny.posit.co/), allows interactive Python applications similar to R’s Shiny framework. This example will guide you in setting up a basic app and preparing it for ShinyProxy.

1. **Create a Shiny App in Python**  
   Install Shiny for Python in your virtual environment:

   ```bash
   pip install shiny
   ```

   Write a simple Shiny app in Python (`app.py`), like this:

   ```python
   from shiny import App, ui, render

   app_ui = ui.page_fluid(
       ui.h2("Hello, Shiny for Python!"),
       ui.input_slider("num", "Choose a number", 1, 100, 50),
       ui.output_text_verbatim("output")
   )

   def server(input, output, session):
       @output
       @render.text
       def output():
           return f"You chose: {input.num()}"

   app = App(app_ui, server)
   ```

2. **Test the Application Locally**  
   Run the app locally to ensure it works as expected:

   ```bash
   shiny run --app app.py
   ```

   Open a browser and navigate to [http://localhost:8000](http://localhost:8000) to view the app.

## 2. Creating a Docker Image for the Shiny App

Packaging the Shiny for Python app in Docker is essential for deployment with ShinyProxy. Here’s how to create a Docker image.

1. **Write a Dockerfile**

   Create a `Dockerfile` to define the image configuration:

   ```Dockerfile
   # Start with a base image that has Python installed
   FROM python:3.10-slim

   # Install Shiny for Python and any additional dependencies
   RUN pip install shiny

   # Copy the app into the container
   COPY app.py /app/app.py
   WORKDIR /app

   # Expose the port Shiny for Python will run on
   EXPOSE 8000

   # Command to run the application
   CMD ["shiny", "run", "--app", "app.py", "--port", "8000", "--host", "0.0.0.0"]
   ```

2. **Build the Docker Image**

   Use the following command to build the Docker image:

   ```bash
   docker build -t shiny-python-app .
   ```

3. **Test the Docker Image Locally**

   Run the container to ensure it functions correctly:

   ```bash
   docker run -p 8000:8000 shiny-python-app
   ```

   Navigate to [http://localhost:8000](http://localhost:8000) to verify the app is running in Docker.

## 3. Setting Up Docker Compose (Optional)

Docker Compose makes it easier to manage and run multiple containers. Create a `docker-compose.yml` file for simpler deployment:

```yaml
version: '3'
services:
  shiny-app:
    image: shiny-python-app
    ports:
      - "8000:8000"
```

To start the application with Docker Compose, run:

```bash
docker-compose up -d
```

## 4. Deploying the App with ShinyProxy

To host the app with ShinyProxy, configure `application.yml`, ShinyProxy’s main configuration file. Here’s a sample configuration:

1. **Edit `application.yml`**

   Add an entry for the Shiny for Python app:

   ```yaml
   proxy:
     title: "Shiny for Python Applications"
     specs:
       - id: shiny-python-app
         display-name: "Shiny Python App"
         container-image: shiny-python-app
         port: 8000
   ```

   - `id`: Unique identifier for the app.
   - `display-name`: The name displayed in ShinyProxy’s app listing.
   - `container-image`: Docker image for the app.
   - `port`: The port Shiny listens on in the container.

2. **Launch ShinyProxy**

   Start or restart ShinyProxy to apply the new configuration.

## 5. Accessing the App

After launching ShinyProxy, navigate to the ShinyProxy dashboard (usually [http://localhost:8080](http://localhost:8080) if hosted locally). Select your app from the list to open it in a new browser tab.

## 6. Debugging Tips

If the application does not start or displays errors, consider:

- **Checking Docker Logs**:

  ```bash
  docker logs <container_id>
  ```

- **Examining ShinyProxy Logs** for detailed error information.
- **Testing with `curl`** to see if the app is reachable:

  ```bash
  curl http://localhost:8000
  ```

## References

- [Shiny for Python Documentation](https://shiny.posit.co/py/docs/overview.html)
- [ShinyProxy Documentation](https://www.shinyproxy.io/)
- [Docker Documentation](https://docs.docker.com/)
