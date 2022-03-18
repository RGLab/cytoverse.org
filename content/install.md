---
title: "Installation Instructions"
---

## Versions

Both the latest stable releases of all Cytoverse packages and more up-to-date development builds can be installed from [Bioconductor](http://bioconductor.org/). If you have not already done so, you will need to install BiocManager by running the following in R:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
```

The most up-to-date development versions can also be built from sources available from [Github](https://github.com/RGLab). If you are building from source on Windows, you will need to install [Rtools](https://cran.r-project.org/bin/windows/Rtools/) and will need to follow some additional instructions for installing [RProtoBufLib](https://github.com/RGLab/RProtoBufLib/blob/master/INSTALL).

## Bundled Installation

The easiest way to install the `cytoverse` packages is by using the [cytoverse](https://github.com/RGLab/cytoverse) installer package. It will show you all of the packages that will be installed before proceeding. This package can be used to later update `cytoverse` packages from either Bioconductor or GitHub.

To install from the stable Bioconductor releases:

```
remotes::install_github("RGLab/cytoverse")
cytoverse::cytoverse_update()
```

To install from the development branches from GitHub:
```
remotes::install_github("RGLab/cytoverse")
cytoverse::cytoverse_update(repo = "github")
```


## Individual Packages

Installing or updating additional RGLab packages can be done in a similar manner, either by utilizing the `cytoverse` installer package:

```
cytoverse::cytoverse_update(pkgs = "flowStats")
```
or manually from Bioconductor:

```
BiocManager::install("flowStats")
```   
or manually from GitHub:  
```
devtools::install_github("RGLab/flowStats")
```

## Cytoverse -> FlowJo

The entire Cytoverse collection of packages is open-source and available from the repositiories listed above, with the
sole exception of the functionality to convert Cytoverse `GatingSet` objects in to FlowJo workspaces. This functionality 
is provided in the form of a Docker image so it will work on any user operating system so long as Docker is installed.

This is not required for using any other parts of the Cytoverse, but if it is functionality you require, please follow
[Docker's installation instructions](https://www.docker.com/get-started) and then follow these instructions to get the appropriate
docker image from [Amazon ECR Public Gallery](https://gallery.ecr.aws/x4k5d9i7/cytoverse/gs-to-wsp):

```
docker pull public.ecr.aws/x4k5d9i7/cytoverse/gs-to-wsp:latest
```

While you can use this tool directly from the command line following the usage instructions
[here](https://gallery.ecr.aws/x4k5d9i7/cytoverse/gs-to-wsp), you can also simply use the `gatingset_to_flowjo` method from
the `CytoML` package after you have obtained the Docker image using the above `docker pull` command.

## Cytoverse Docker Image

Docker images are also provided based on the [Docker images available from Bioconductor](https://www.bioconductor.org/help/docker/), with the Cytoverse packages pre-installed. These Cytoverse Docker images are also available from the [RGLab Docker Hub page](https://hub.docker.com/r/rglab/cytoverse).