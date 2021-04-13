# integratedml-demo-template
This is a template for IntegratedML - InterSystems Github repository.

This repository comes with a few example Jupyter notebooks (http://jupyter.org) which demonstrate how to use IntegratedML in InterSystems IRIS Community Edition (Advanced Analytics including IntegratedML) in a docker container.

## Contents
* [What is IntegratedML?](#what-is-integratedml)
* [What's inside this template](#whats-inside-this-template)
* [Pre-configured environment, and sample data](#pre-configured-environment-and-sample-data)
   * [Sample notebooks to get you started](#sample-notebooks-to-get-you-started)
   * [Demo environment topology](#demo-environment-topology)
   * [Prerequisites](#prerequisites)
   * [Tested environments](#tested-environments)
   * [Installation](#installation)
* [How to develop your IntegragedML solution with the IntegratedML Template Repo](#how-to-develop-your-integragedml-solution-with-the-integratedml-template-repository)
   * [Use this template](#use-this-template)
   * [Checkout the repo](#checkout-the-repo)
   * [Start developing](#start-developing)
* [How to Import data into InterSystems IRIS](#how-to-import-data-into-intersystems-iris)
   * [Importing data from CSV file](#importing-data-from-csv-file)
   * [Importing data from CSV URL](#importing-data-from-csv-url)

## What is IntegratedML?
IntegratedML is a feature of the InterSystems IRIS data platform that brings machine learning to SQL developers.
<p align="center">
  <img src="https://user-images.githubusercontent.com/8899513/85149599-7848f900-b21f-11ea-9b65-b5d703752de3.PNG" width="600" title="docker environment topology after installation">
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
4 sample notebook files -- by default this template starts Jupyter at http://localhost:8896/tree :
- [campaign-integratedml-jdbc.ipynb](jupyter-samples/campaign-integratedml-jdbc.ipynb): A simple JDBC connection from tf2jupyter into a sample data table (Marketing Campaign data) within InterSystems IRIS's USER namespace, showing some use of IntegratedML including VALIDATE MODEL command usage.
- [readmission-integratedml-jdbc.ipynb](jupyter-samples/readmission-integratedml-jdbc.ipynb): Demonstrates use of IntegratedML on a hospital readmission prediction dataset. 
- [biomedical-integratedml-PyODBC.ipynb](jupyter-samples/biomedical-integratedml-PyODBC.ipynb): Connection to InterSystems IRIS server over PyODBC, building and using an IntegratedML machine learning model, with a complex SQL query using the PREDICT() and PROBABILITY() IntegratedML SQL functions.
- [ED_visit_90_day.ipynb](jupyter-samples/ED_visit_90_day.ipynb): Building and using an IntegratedML machine learning model to predict visits to Emergency Department, utilizing data from a Health Insight server, kindly provided by Joseph Cofone at Baystate Health. *NOTE: this notebook is not executable!*

## Demo environment topology
<p align="center">
  <img src="https://user-images.githubusercontent.com/8899513/85151307-a0d1f280-b221-11ea-81d8-f0e11ca45d4c.PNG" width="600" title="docker environment topology after installation">
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

5. Examine the test data with webterminal
Open terminal with: SuperUser / SYS credentials
```
http://localhost:8092/terminal/
```
Enter **/sql** mode and make SQL queries to examine data in IRIS.
![](https://user-images.githubusercontent.com/8899513/85151564-edb5c900-b221-11ea-96d4-1833a93c47eb.png?raw=true)

# How to develop your IntegragedML solution with the IntegratedML Template Repository
## Use this template
Click the button "Use this template" on Github to create a new repository which will be the copy of this one.

## Checkout the repo
Clone your new repo to a local folder.  

## Start developing
Install [VSCode](https://code.visualstudio.com/), [Docker Desctop](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) and [ObjectScript](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript) plugin and open the folder in VSCode.

Import your data as listed below, rebuild containers to let the data be imported, and use IntegratedML via SQL tools, as described in Jupyter notebooks.


# How to Import data into InterSystems IRIS 
## Importing data from CSV file
1. Add csv file into the repository, e.g. like [this titanic.csv](https://github.com/intersystems-community/integratedml-demo-template/blob/master/iris-aa-server/data/titanic.csv)
2. Introduce an import data call into your IRIS initalisation script.
This is an [example line to import titanic.csv](https://github.com/intersystems-community/integratedml-demo-template/blob/7feaffef0a47c7c46cc683d89bdbaedbce48071c/iris-aa-server/iris.script#L16) into IRIS User.Passengers class along with data.
3. Query the data from any SQL tool, web terminal or from InterSystems ObjectScript with:
```
SELECT * From Passengers
```
## Importing data from CSV URL
If your file is accessible remotely, you can import it as follows:
1. Add the import CSV from URL line into [iris.script](https://github.com/intersystems-community/integratedml-demo-template/blob/master/iris-aa-server/iris.script).
Here is an example line to [import countries.csv data from URL](https://github.com/intersystems-community/integratedml-demo-template/blob/7feaffef0a47c7c46cc683d89bdbaedbce48071c/iris-aa-server/iris.script#L17)
2. Rebuild the docker image (the easiest way is to rebuild via _docker-compose_ -- ```docker-compose build```). This will create User.Countries class and import data which you can query with SQL from Countries table:
```
SELECT * FROM COUNTRIES
```

