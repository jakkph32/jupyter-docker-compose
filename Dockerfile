# Use an official Jupyter Docker image as a parent image
FROM jupyter/base-notebook:latest

# Set environment variables
ENV JUPYTER_ENABLE_LAB: yes
ENV JUPYTER_TOKEN: token
ENV NB_USER: jupyternb
ENV NB_UID: 1000
ENV NB_GID: 100
ENV CHOWN_HOME: yes
ENV CHOWN_HOME_OPTS: -R

USER root

# Copy the Jupyter notebooks to the working directory
COPY . /home/jovyan/work

# Set the working directory
WORKDIR /home/jovyan/work

# Expose the port Jupyter uses
EXPOSE 8888

# Start Jupyter notebook
CMD ["start-notebook.sh"]
