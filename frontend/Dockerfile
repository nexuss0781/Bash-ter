# Use slim Python image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Expose Flask Port
EXPOSE 5000

# Run Gunicorn
# access-logfile - means log to stdout so you can see it in Docker
CMD ["gunicorn", "-w", "2", "-b", "0.0.0.0:5000", "--access-logfile", "-", "app:app"]
