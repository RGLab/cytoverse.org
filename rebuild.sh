#!/bin/sh
rm -rf docs
Rscript -e 'blogdown::build_site()'
cp -r public docs
cp CNAME docs
