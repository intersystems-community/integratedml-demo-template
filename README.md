## integratedml-demo-template
IntegratedML samples to be used as a template


This is a template for IntegratedML - InterSystems Github repository.

The template also comes with a few example Jupyter notebooks (http://jupyter.org) which demonstrate how to use IntegratedML in InterSystems IRIS Community Edition (Advanced Analytics including IntegratedML) in a docker container.

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

## Installation

Clone/git pull the repo into any local directory

```
$ git clone https://github.com/tom-dyar/integratedml-demo-template.git
```

Open the terminal in this directory and run:

```
$ docker-compose build
```

3. Run the IRIS container, and Jupyter notebook server images:

```
$ docker-compose up -d
```

4. Open browser to view and edit notebooks

```
Copy notebook id (how to describe this step??)
Open http://localhost:8094/
Paste notebook id into field
```

## What's inside the repository

## Content

### Notebook #1
### Notebook #2

## DevOps

### Dockerfile

The simplest dockerfile which starts IRIS and imports Installer.cls and then runs the Installer.setup method, which creates IRISAPP Namespace and imports ObjectScript code from /src folder into it.
Use the related docker-compose.yml to easily setup additional parameters like port number and where you map keys and host folders.
Use .env/ file to adjust the dockerfile being used in docker-compose.
