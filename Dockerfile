# Use a lightweight Python image
FROM python:3.10-slim

# Prevent Python from writing .pyc files and buffer outputs
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set the working directory inside the container
WORKDIR /app

# Install system dependencies (minimal)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy all project files to container
COPY . .

# Install Python dependencies (editable mode)
RUN pip install --no-cache-dir -e .

# Run the training script (RFC training)
RUN python main.py

# Expose the port used by Flask
EXPOSE 5000

# Run the Flask application
CMD ["python", "application.py"]
