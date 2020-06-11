## integratedml-demo-template
IntegratedML samples to be used as a template.

This is a template for IntegratedML - InterSystems Github repository

The template also comes with a few example Jupyter notebooks (http://jupyter.org) which demonstrate how to use IntegratedML in InterSystems IRIS Community Edition (Advanced Analytics including IntegratedML) in a docker container.

## What's inside this template

### pre-configured environment, and sample data
This template creates a docker environment (via "docker-compose up") of 2 pre-configured containers:
  1. tf2jupyter: Jupyter+Tensorflow2.2(without GPU), with a few sample notebook files (in its Dockerfile)
  2. irisimlsvr another one for an IRIS 2020.3 Community Edition, with pre-loaded sample data in USER namespace(see its Dockerfile)

### sample notebook to start with
3x sample notebook files in this template:
  1. A simple JDBC connection from tf2jupyter into a sample data table (Iris flowers) within IRIS's USER.
  2. The above plus a few pandas data frame operatons and read/wrtie samples data into IRIS's USER.
  3. The above plus some very basic, initial SQL syntax demox of using IRIS IntegratedML.

## Demo environment topology
<p align="center">
  <img src="environment_topology_demo_template.PNG" width="600" title="docker environment topology after installation">
</p>

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

## Tested environments
This template is tested breifly on AWS Ubuntu, Mac OS, and Windows 10(using Docker Toolbox only). It should work on other Docker environment too - let us know if you encounter any issues.

## Installation

Clone/git pull the repo into any local directory

```
$ git clone https://github.com/tom-dyar/integratedml-demo-template.git
```

Open a Docker terminal in this directory and run:

```
$ docker-compose build
```

3. Run the IRIS container, and Jupyter notebook server images:

```
$ docker-compose up -d
```

4. Open browser to access the notebooks

firstly, acquire the Jupyter server token by running
```
$ docker logs tf2jupyter
```
```
Copy notebook token id
Open http://localhost:8896/tree  
Paste in notebook id
```
Note: use "Docker ps" to confirm tf2juyter's ports; make sure right localhost port is used if over SSL tunneling to remotehost)


## Starts
1. Test the provided notebooks.
2. Starting from there, try whatever you could image with your own data within IRIS


## What's next
1. We can put in more demo notebooks on PyODBC, PySpark(no bespoke SQL syntax hence no IML SQL), IRISNative etcetc


## Purpose
Purpose of this template is to provide the simplest tools for data developers to connect into IRIS database via commonly used Python3 +  Jupyter notebooks. 

From there the developer can either go for exploreing the current IntegratedML Syntax (in SQL), or run the data through some ML/DL pipelines on the backend Tensorflow 2.2 engines.  

The above explains how to simply read from and write into IRIS via Python3. Please also refer to [Python Gateway template](https://openexchange.intersystems.com/package/PythonGateway-Template) on how to invoke external Python applications or service from within IRIS. 
