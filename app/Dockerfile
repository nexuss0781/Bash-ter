# Use lightweight Python image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Expose the internal Flask port
EXPOSE 5000

# Run with Gunicorn (Production Server) instead of default Flask dev server
# 4 workers for handling concurrent requests
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "app:app"]
