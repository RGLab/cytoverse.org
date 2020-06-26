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

## Core Packages

There are a number of packages that manage the core data structures used by all other Cytoverse packages. The different versions of these can be installed in the following ways.

Latest stable releases from Bioconductor:
```
core_packages <- c("RProtoBufLib", "cytolib", "flowCore", "ncdfFlow", "flowWorkspace")
BiocManager::install(core_packages)
```

Development branches from Bioconductor:
```
core_packages <- c("RProtoBufLib", "cytolib", "flowCore", "ncdfFlow", "flowWorkspace")
BiocManager::install(version='devel')
BiocManager::install(core_packages)
```

Build from GitHub source:
```
core_packages <- c("RProtoBufLib", "cytolib", "flowCore", "ncdfFlow", "flowWorkspace")
devtools::install_github(paste0("RGLab/", core_packages))
```

## Main Extensions

These are packages used for visualization (ggcyto), reading/writing workspace files from other software (CytoML), and constructing automated gating pipelines (openCyto). They are the most commonly used additional components.

Latest stable releases from Bioconductor:
```
extensions <- c("openCyto", "CytoML", "ggcyto")
BiocManager::install(extensions)
```

Development branches from Bioconductor:
```
extensions <- c("openCyto", "CytoML", "ggcyto")
BiocManager::install(version='devel')
BiocManager::install(extensions)
```

Build from GitHub source:
```
extensions <- c("openCyto", "CytoML", "ggcyto")
devtools::install_github(paste0("RGLab/", extensions))
```

## Additional Individual Packages

A number of other packages are very useful in coordination with the core cytoverse packages, primarily providing additional
statistical methods. Some examples include
[flowStats](https://github.com/RGLab/flowStats) and [flowClust](https://github.com/RGLab/flowClust).
These can be installed in a similar way to the groups of packages above. Using `flowStats` as an example:

Latest stable releases from Bioconductor:
```
BiocManager::install("flowStats")
```

Development branch from Bioconductor:
```
BiocManager::install(version='devel')
BiocManager::install("flowStats")
```

Build from GitHub source:
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