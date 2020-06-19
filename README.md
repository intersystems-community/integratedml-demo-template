## integratedml-demo-template
This is a template for IntegratedML - InterSystems Github repository

This repository comes with a few example Jupyter notebooks (http://jupyter.org) which demonstrate how to use IntegratedML in InterSystems IRIS Community Edition (Advanced Analytics including IntegratedML) in a docker container.

## What is IntegratedML?
IntegratedML is a feature of the InterSystems IRIS data platform that brings machine learning to SQL developers.
<p align="center">
  <img src="https://raw.githubusercontent.com/intersystems-community/integratedml-demo-template/master/integratedml_overview.PNG" width="600" title="docker environment topology after installation">
</p>

IntegratedML is
- all-SQL -- Build and train machine learning models using intuitive custom SQL commands, fully integrated within the InterSystems IRIS SQL processor
- turnkey -- no packages or programming languages to learn, nothing to install
- modular -- leverages "best of breed" open source and proprietary AutoML frameworks

Learn more about InterSystems IRIS and IntegratedML at the [InterSystems Learning site](https://learning.intersystems.com/course/view.php?name=Learn%20IntegratedML)

## What's inside this template

### Pre-configured environment, and sample data
This template creates a docker environment (via "docker-compose up") of 2 pre-configured containers:
  1. tf2jupyter: Jupyter+Tensorflow2.2(without GPU), with a few sample notebook files (in its Dockerfile)
  2. irisimlsvr another one for an IRIS 2020.3 Community Edition, with pre-loaded sample data in USER namespace(see its [Dockerfile](iris-aa-server/Dockerfile) and [iris.script](iris-aa-server/iris.script) that is run at startup)

### Sample notebooks to get you started
2 sample notebook files in this template:
- [campaign-integratedml-jdbc.ipynb](jupyter-samples/campaign-integratedml-jdbc.ipynb): A simple JDBC connection from tf2jupyter into a sample data table (Marketing Campaign data) within InterSystems IRIS's USER namespace, showing some use of IntegratedML including VALIDATE MODEL command usage.
- [biomedical-integratedml-PyODBC.ipynb](jupyter-samples/biomedical-integratedml-PyODBC.ipynb): Connection to InterSystems IRIS server over PyODBC, building and using an IntegratedML machine learning mode, with a complex SQL query using the PREDICT() and PROBABILITY() IntegratedML SQL functions.

## Demo environment topology
<p align="center">
  <img src="https://raw.githubusercontent.com/intersystems-community/integratedml-demo-template/master/environment_topology_demo_template.PNG" width="600" title="docker environment topology after installation">
</p>

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

## Tested environments
This template is tested breifly on AWS Ubuntu, Mac OS, and Windows 10(using Docker Toolbox only). It should work on other Docker environment too - let us know if you encounter any issues.

## Installation

Clone/git pull the repo into any local directory

```
$ git clone https://github.com/intersystems-community/integratedml-demo-template.git
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

```
http://localhost:8896/tree
```
Note: use `docker-compose ps` to confirm tf2juyter's ports; make sure right localhost port is used if over SSL tunneling to remotehost)
