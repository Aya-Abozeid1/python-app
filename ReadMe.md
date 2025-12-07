This project demonstrates how to dockerize a Python Flask application. The Dockerfile creates a lightweight image that includes all dependencies and exposes the app on a specified port.


**Dockerfile**

# Use lightweight Python image
FROM python:3.12.12-alpine3.23

# Install needed packages for troubleshooting
RUN apk update
RUN apk add curl nano

# Set working directory
WORKDIR /app

# Copy application code and ignore any unnecessary file
COPY . /app

# Install Prometheus plugin for thr monitoring
RUN pip install prometheus-client

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose port used by the Flask app
EXPOSE 5000

# Command to run the app
CMD ["python", "run.py"]




