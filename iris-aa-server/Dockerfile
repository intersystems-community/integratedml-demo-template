# InterSystems IRIS Community Edition with ZPM - updated December 2025
# Using intersystemsdc image with ZPM pre-installed (valid license, regularly updated)
ARG IMAGE=intersystemsdc/iris-community:latest-em-zpm
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

# Run iris.script during build to install ZPM packages and load data
RUN iris start IRIS \
    && iris session IRIS < /tmp/iris.script \
    && iris stop IRIS quietly
