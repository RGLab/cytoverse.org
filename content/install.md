---
title: "Installation"
---

## Bundled Installation

The most recent stable release of the packages can be installed from [Bioconductor](http://bioconductor.org/) in R by running:   
`BiocManager::install("cytoverse")`     
The most current development versions can obtained from [Github](https://github.com/RGLab) by running:    `devtools::install_github("RGLab/cytoverse")`   

## Individual Packages

A number of packages are very useful in coordination with the core cytoverse packages but are not included
in the bundled installation above. Some examples include
[flowStats](https://github.com/RGLab/flowStats) and [flowClust](https://github.com/RGLab/flowClust).

These can be installed in a similar way to the bundled installation above, either from Bioconductor:
```
BiocManager::install("flowStats")
```   
or from GitHub:   
```
devtools::install_github("RGLab/flowStats")
```

## Cytoverse -> FlowJo

The entire Cytoverse collection of packages is open-source and available from the repositiories listed above, with the
sole exception of the functionality to convert Cytoverse `GatingSet` objects in to FlowJo workspaces. This functionality 
is provided in the form of a Docker image so it will work on any user operating system so long as Docker is installed.

This is not required for using any other parts of the Cytoverse, but if it is functionality you require, please follow
[Docker's installation instructions](https://www.docker.com/get-started) and then follow these instructions to get the appropriate
docker image from [Docker Hub](https://hub.docker.com/r/rglab/gs-to-flowjo):

* If you have installed the packages from a particular Bioconductor release:
    1. Determine the major and minor version of your `cytolib` installation by using the following command in `R`:
    ```
    packageVersion("cytolib")
    ```
    2. Pull the docker image tagged with the corresponding major and minor `cytolib` version. For example, if the command above
    returns that your `cytolib` version is `2.0.2`, you should use:
    ```
    docker pull rglab/gs-to-flowjo:2.0
    ```
* If you have installed the packages from the current GitHub development branches, please pull the "devel" tagged image. For example:
    ```
    docker pull rglab/gs-to-flowjo:devel
    ```
While you can use this tool directly from the command line following the usage instructions
[here](https://hub.docker.com/r/rglab/gs-to-flowjo), you can also simply use the `gatingset_to_flowjo` method from
the `CytoML` package after you have obtained the Docker image using the above `docker pull` command.

## Cytoverse Docker Image

Docker images are also provided based on the [Docker images available from Bioconductor](https://www.bioconductor.org/help/docker/), with the Cytoverse packages pre-installed. These Cytoverse Docker images are also available from the [RGLab Docker Hub page](https://hub.docker.com/r/rglab/cytoverse).