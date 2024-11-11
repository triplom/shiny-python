# Use the official Python image from the Docker Hub
FROM python:3.10
# Set the working directory in the container
WORKDIR /app
# Copy the requirements file into the container
COPY requirements.txt .
# Install the required Python packages
RUN pip3 install -r requirements.txt
# Copy the rest of the application code into the container
COPY ./app.py .
# Expose port 8080 to the outside world
EXPOSE 8080
# Command to run the application using Gunicorn with Uvicorn workers
CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:8080", "-k", "uvicorn.workers.UvicornWorker"]