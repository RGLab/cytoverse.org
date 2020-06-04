#!/bin/sh
rm -rf docs public
Rscript -e 'blogdown::build_site()'
Rscript -e 'blogdown::build_dir("static", force = TRUE)'
cp -r public docs
cp CNAME docs
