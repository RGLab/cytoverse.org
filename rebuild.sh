#!/bin/sh
rm -rf docs public
Rscript -e 'blogdown::build_dir("static")'
Rscript -e 'blogdown::build_site()'
cp -r public docs
cp CNAME docs
