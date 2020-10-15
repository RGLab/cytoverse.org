---
title: "1d historgram/density plot of cytometry data with ggplot2"
author: "Mike Jiang"
output:
  html_document:
    keep_md: yes
vignette: >    
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteIndexEntry{1d historgram/density plot of cytometry data with ggplot2}        
---



`ggcyto` makes `ggplot2` to be able to work with `Cytometry` data, namely `flowSet/ncdfFlowSet` or `flowFrame` S4 objects.



```r
library(ggcyto)
data(GvHD)
fs <- GvHD[subset(pData(GvHD), Patient %in%5:7 & Visit %in% c(5:6))[["name"]]]
fr <- fs[[1]]
```

## 1d histogram/densityplot

```r
# histogram at raw scale
p <- ggplot(fr, aes(x = `FL1-H`)) 
p + geom_histogram() 
```

![](ggplot.flowSet.1d_files/figure-html/unnamed-chunk-3-1.svg)<!-- -->

```r
# customize border colors and log scale 
p + geom_histogram(colour = "white") + scale_x_log10()
```

![](ggplot.flowSet.1d_files/figure-html/unnamed-chunk-3-2.svg)<!-- -->

```r
# change the bin width
p + geom_histogram(colour = "white", binwidth = 1/20) + scale_x_log10()
```

![](ggplot.flowSet.1d_files/figure-html/unnamed-chunk-3-3.svg)<!-- -->

```r
# logicle scale with default parameters setting (e.g. t = 262144)
p <- p + geom_histogram(colour = "white")
p + scale_x_logicle()
```

![](ggplot.flowSet.1d_files/figure-html/unnamed-chunk-3-4.svg)<!-- -->

```r
# logicle scale with customized parameter
p + scale_x_logicle(t = 1e4, w = 0)
```

![](ggplot.flowSet.1d_files/figure-html/unnamed-chunk-3-5.svg)<!-- -->

```r
# customized breaks
myBreaks <- c(0, 10, 1e2, 1e3)
p  + scale_x_logicle(t = 1e4, w = 0, breaks = myBreaks)
```

![](ggplot.flowSet.1d_files/figure-html/unnamed-chunk-3-6.svg)<!-- -->

```r
# remove marginal events
p  + scale_x_logicle(t = 1e4, w = 0, breaks = myBreaks, limits = c(2, 1e4))
```

![](ggplot.flowSet.1d_files/figure-html/unnamed-chunk-3-7.svg)<!-- -->

```r
# other scales: flowJo_fasinh, flowJo_biexp
p + scale_x_flowJo_fasinh(t = 1e4)
```

![](ggplot.flowSet.1d_files/figure-html/unnamed-chunk-3-8.svg)<!-- -->

```r
p + scale_x_flowJo_biexp(maxValue = 1e4, widthBasis = 0)
```

![](ggplot.flowSet.1d_files/figure-html/unnamed-chunk-3-9.svg)<!-- -->

```r
# save the scales
# myScales <- scale_x_flowJo_biexp(maxValue = 1e4, widthBasis = 0)


# density  (default y is density)
p <- ggplot(fr, aes(x = `FL1-H`)) 
p + geom_density() + scale_x_log10()
```

![](ggplot.flowSet.1d_files/figure-html/unnamed-chunk-3-10.svg)<!-- -->

```r
# display area
p + geom_area(stat = "density") + scale_x_log10()
```

![](ggplot.flowSet.1d_files/figure-html/unnamed-chunk-3-11.svg)<!-- -->

```r
# display y as count
p + geom_area(stat = "density", aes(y = ..count..))+ scale_x_log10()
```

![](ggplot.flowSet.1d_files/figure-html/unnamed-chunk-3-12.svg)<!-- -->

```r
# histogram + density line
ggplot(fr, aes(x = `FL1-H`, y = ..density..)) + geom_histogram(colour = "white") + geom_density(color = "red") + scale_x_log10()
```

![](ggplot.flowSet.1d_files/figure-html/unnamed-chunk-3-13.svg)<!-- -->

```r
# plot multiple samples
p <- ggplot(fs, aes(x = `FL1-H`)) + geom_area(stat = "density")+ scale_x_log10()
# facetting by sample names
p + facet_wrap(~name) 
```

![](ggplot.flowSet.1d_files/figure-html/unnamed-chunk-3-14.svg)<!-- -->

```r
# faceeting by other pheno data stored in fs
p + facet_grid(Patient~Visit)
```

![](ggplot.flowSet.1d_files/figure-html/unnamed-chunk-3-15.svg)<!-- -->

```r
# fill with different colors
ggplot(fs, aes(x = `FL1-H`, fill = name)) + facet_wrap(~name) +  geom_density(alpha = 0.2)+ scale_x_log10()
```

![](ggplot.flowSet.1d_files/figure-html/unnamed-chunk-3-16.svg)<!-- -->

```r
# or plot in the same panel
ggplot(fs, aes(x = `FL1-H`, fill = name)) + geom_density(alpha = 0.2) + scale_x_log10()
```

![](ggplot.flowSet.1d_files/figure-html/unnamed-chunk-3-17.svg)<!-- -->

