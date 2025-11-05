# -----------------------
# Stage 1: Builder (for linting)
# -----------------------
FROM python:3.12-slim AS builder

WORKDIR /app

# Copy requirements and install
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY app/ .

# Lint code
RUN pip install --no-cache-dir flake8 && flake8 .

# -----------------------
# Stage 2: Production
# -----------------------
FROM python:3.12-slim

WORKDIR /app

# Copy app code
COPY app/ .

# Install requirements again (ensures Flask is available)
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Expose Flask port
EXPOSE 5000

# Run app
CMD ["python", "app.py"]
