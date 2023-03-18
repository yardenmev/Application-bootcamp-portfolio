# Use the official Python 3.12.0a6-slim image as a base
FROM python:3.12.0a6-slim

# Set the working directory to /app
WORKDIR /app

# Copy all files next to the Dockerfile into the image.
COPY . /app

# Install required packages from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 5000
EXPOSE 5000

# Set the default command to run when the container starts
CMD ["python3", "todo.py"]