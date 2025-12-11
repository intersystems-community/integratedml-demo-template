# InterSystems IRIS Community Edition - updated December 2025
# Using official InterSystems registry (valid license, multi-arch ARM64/AMD64)
ARG IMAGE=containers.intersystems.com/intersystems/iris-community:latest-em
FROM $IMAGE
LABEL maintainer="Thomas Dyar <Thomas.Dyar@intersystems.com>"

USER root
RUN mkdir /data \
	&& chown irisowner /data

# Install IntegratedML AutoML provider from InterSystems registry
RUN pip3 install --break-system-packages --no-cache-dir \
    --index-url https://registry.intersystems.com/pypi/simple \
    --target /usr/irissys/mgr/python \
    intersystems-iris-automl

USER irisowner

# Copy data files and source code
COPY data /data
COPY src /data/src
COPY iris.script /tmp/iris.script

# Note: Data loading happens at container startup via iris.script
# The iris.script is executed when the container starts for the first time

# Copy iris.script to the location where it will be auto-executed at startup
COPY iris.script /home/irisowner/iris.script
