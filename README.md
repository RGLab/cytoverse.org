## cytoverse.org

This repo is the source of [https://cytoverse.org](https://cytoverse.org), which serves as hub for information about the cytoverse packages, including:

* A landing gallery showcasing the core packages, with links to corresponding Bioconductor pages
* Installation instructions and link to Docker images
* Brief guidance on learning how to use the packages
* A browsable gallery of examples built from Rmd files
* A blog (not used yet, but it's set up)
* A page on getting help (bug reports, feature requests, contribution instructions)
* Citation instructions
* Link out to GitHub cytoverse installation package

### Development

The site is built using [blogdown](https://bookdown.org/yihui/blogdown/), which in turn is built on [Hugo](https://gohugo.io/), adding in support for R markdown files. However, much of the site has been heavily customized due to limitations of blogdown and available templates. In particular, the main landing gallery/showcase and the examples gallery are built from scratch. The individual package websites are built with [pkgdown](https://pkgdown.r-lib.org/).

Updating the main website structure will require updating the main [`config.toml`](https://bookdown.org/yihui/blogdown/configuration.html#toml-syntax). Updating individual pages requires updating the HTML and [Hugo templates](https://gohugo.io/templates/introduction/) under `themes/hugo-lithium/layouts` and the styling in `themes/hugo-lithium/static/css/main.css`.

However, just adding new content to the website (examples or blog posts) can be accomplished with a more simplified workflow.

### Workflow for adding new content

The high-level workflow is just this:

* Add new content
* run `bash rebuild.sh`
* Run `blogdown::serve_site()` and preview the site
* Commit and push all changes

But more details on each of those steps follow.

#### Adding a blog post

Blog posts can be written in simple Rmd, as formatting will be applied by the Hugo templates and CSS. The Rmd should then be added to `content/post`.

#### Adding an example

Adding a new example file (Rmd) is slightly trickier because it currently still needs to be manually guided to the appropriate place in the examples directory hierarchy.

1) Add the Rmd under the appropriate package directory in `static/examples`. For example, a new example for use of `flowjo_to_gatingset` would go under `static/examples/CytoML`.
2) Add a line to the appropriate `_index.md` markdown file in `content/examples`. These files just dictate the scaffold/structure of the examples as they hook in to the gallery. For example, as of the time of writing this, this is the content of `content/examples/CytoML/_index.md`:

```
---
title: "CytoML"
docs:
    - 'cytobank experiment to GatingSet': 'CytobankExperiment.html'
    - 'Import FlowJo workspace to R': 'flowjo_to_gatingset.html'
---
```
The keys here will be used to generate the title for the example in the gallery, while the values are simply the base filenames (no directory prepended). So, if we are adding a new example file `new_features.Rmd` to `static/examples/CytoML`, we could hook that in to the gallery by adding a new line to `content/examples/CytoML/_index.md` as follows:

```
---
title: "CytoML"
docs:
    - 'cytobank experiment to GatingSet': 'CytobankExperiment.html'
    - 'Import FlowJo workspace to R': 'flowjo_to_gatingset.html'
    - 'New Features of flowjo_to_gatingset': 'new_features.Rmd'
---
```
In the gallery, the HTML resulting from rendering `new_features.Rmd` would then be hooked in to the browser with the label "New Features of flowjo_to_gatingset".

#### Rebuilding the website

Once the changes have been made to add new content, run `bash rebuild.sh` from the top-level directory. This may take a while as this is when new examples are run and rendered and the pages are rebuilt. This is a simple script:

```
#!/bin/sh
rm -rf docs public
Rscript -e 'blogdown::stop_server()'
Rscript -e 'blogdown::build_dir("static")'
Rscript -e 'blogdown::build_site()'
cp -r public docs
cp CNAME docs
```

It starts by purging the docs and public directories and stopping the server. Both of these are to make sure the build starts with a clean slate, as otherwise prior artifacts tended to create interference. 

Then, it will rebuild all of the assets under the `static` directory. This is where the example `Rmd` file added will be rendered. By default, this will not re-render HTML files for `Rmd` files that have not changed. If you want to fully rebuild all examples, simply change `Rscript -e 'blogdown::build_dir("static")'` to `Rscript -e 'blogdown::build_dir("static", force = TRUE)'`. For the record, the example `Rmd` files need to go under the `static` directory (as opposed to directly under `content/examples`) due to some Hugo/blogdown quirks in order for them to be copied to the appropriate location in `public` when it is generated.

Next `blogdown::build_site` will build the `public` directory using the provided configuration and templates to generate all pages. That is then copied to the `docs` directory for serving the site.

Finally, the CNAME file is copied over to the docs directory to tell GitHub pages to link it up to the custom domain (`cytoverse.org`).

#### Previewing the website

At this point, running `blogdown::serve_site()` in RStudio will allow you to view a preview in the viewer or in a web browser. You should verify that all pages have successfully rebuilt, in particular making sure that the newly added examples (or all examples if you are rebuilding all) have rendered correctly in the gallery. For example, if `Rmarkdown::render` hit any errors, there may be a bunch of missing `png` files. But that should also be obvious from the git status.

#### Finalizing changes

At this point, all of the changes can be committed and pushed to the `master` branch of [RGLab/cytoverse.org](https://github.com/RGLab/cytoverse.org). You can monitor the deployment of the changes [here](https://github.com/RGLab/cytoverse.org/deployments).


### Individual package websites

Individual `rglab/github.io` package websites that `cytoverse.org` links to, like the site for [flowWorkspace](https://rglab.github.io/flowWorkspace/) are just built with pretty standard `pkgdown` configuration using a [`_pkgdown.yaml`](https://github.com/RGLab/flowWorkspace/blob/master/_pkgdown.yml) in the `master` branch (the branch used for the website can be changed from the administration options for the package on GitHub). Again, after changes are made there, you will need to run `pkgdown::build_site()` and commit/push the changes.

The most common changes there will involve adding in new lines to link up docs for new functions or changing logical organization of the docs by moving them between headers.

