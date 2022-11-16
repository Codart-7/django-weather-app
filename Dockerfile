# Alpine base image
FROM python:3.7-slim

# Set working directory
WORKDIR /usr/src/app

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Copy the entire project
COPY . /usr/src/app

# Upgrade pip and install dependencies
RUN apt-get update && apt-get -y install --no-install-recommends default-libmysqlclient-dev libpq-dev gcc && rm -rf /var/lib/apt/lists/* && pip install -r requirements.txt

# Migrations
CMD python manage.py makemigrations
CMD python manage.py migrate

# Expose the port
EXPOSE 8000

# Run the server
CMD ["python", "manage.py", "runserver"]
