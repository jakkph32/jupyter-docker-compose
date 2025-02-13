# Use an official Jupyter Docker image as a parent image
FROM jupyter/base-notebook:latest

# Set environment variables
ENV JUPYTER_ENABLE_LAB=yes

# Copy the Jupyter notebooks to the working directory
COPY . /etc/jupytor-docker-compose/work

# Set the working directory
WORKDIR /etc/jupytor-docker-compose/work

# Expose the port Jupyter uses
EXPOSE 8888

# Start Jupyter notebook
CMD ["start-notebook.sh"]
