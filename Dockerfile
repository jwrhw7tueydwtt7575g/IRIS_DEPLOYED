# Use a lightweight Python image
FROM python:slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install system dependencies required by LightGBM
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgomp1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy the application code into container
COPY . .

# Install required Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Run RFC training before application starts
RUN python app.py

# Expose Flask port
EXPOSE 5000

# Run the Flask app
CMD ["python", "application.py"]
