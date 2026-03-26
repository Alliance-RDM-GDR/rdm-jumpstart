**Refer to the resources in `_getting_started/` for support with GitHub**

**Refer to `qmd/extras/template.qmd` for support with Quarto and page formatting.**

## Quarto

### Overview

Quarto builds a website using parameters set in `_quarto.yml`, which controls site structure, including site navigation. Using `knitr`, it takes in all `.qmd` and `.Rmd` files it can find (this behavious is recursive in directories), and renders them to `html` and connects them based on the paramters outlined in `_quarto.yml`.

In our case, the site is rendered to the directory `docs/`. If this directory does not yet exist, it will create it. If it already exists, it will overwrite it. **To avoid unnecessary merge conflicts, `docs/` is ignored by `Git`. We will push the `docs/` directory to GitHub when we're ready to publish the course.**

Rendering the site is most easily done from within RStudio's GUI. Open `rdm-jumpstart.Rproj`, go to the `Build` tab and select `Render Website`. In addition to rendering the wite to `docs/` it will also launch a local server and deploy the site. Once the site is deployed, Quarto will continue to listen for modifications to any configuration files (`.yml`, `.scss`, etc.). However, after modifying a `.qmd` file, you will need to rebuild; Quarto will rebuild only the modified files and launch a new local server.

### Key Resources

The reference documentation is critical to properly setting up the site, including organizing navigation, customizing css, etc.

* [Website Options](https://quarto.org/docs/reference/projects/websites.html): High level website options for `_quarto.yml` for setting navigation options, page footers, etc.
* [HTML Theming](https://quarto.org/docs/output-formats/html-themes.html): More granular options for custom theming through Sass variable, mostly connected with `styles.scss`.
* [More About Quarto themes](https://quarto.org/docs/output-formats/html-themes-more.html): Instructions for how to set up `styles.scss` so that it actually works.
* [HTML Options](https://quarto.org/docs/reference/formats/html.html): Mostly these apply to standalone html documents, but some features are used in `_quarto.yml`.

## Project Structure

| File | Description |
| :--- | :--- |
| _quarto.yml | Key configuration file. Please don't touch. |
| README.md | This file. Please read and keep updated. |

| Directory | Description |
| :--- | :--- |
| _getting_started | A series of 'how to' articles. Not updated since 2025 |
| docs | Website build location. It will remain absent until we push the rendered site. |
| files | All data files should go here. |
| images | All images used across the site. Block specific images should be stored in their respective folders `qmd > block* > images`. |
| qmd | All qmd files. There is a subdirectory for each block. The included `readme.md` file has additional details. |
| scripts | Currently a layover from 2025. May delete. |
| style-sheets | Custom scss code. |

**Make sure your `.gitignore` file is properly configured. We don't want to see your `.Rproj.user` file, your `.DS_Store` file if you're on a mac, or any other hidden or personal files you may have in your directory :)**

# Naming Conventions

**TBD**

# Future Development Options

## Multilingual Site

`babelquarto` allows for toggling of translated content. Details [here](https://github.com/ropensci-review-tools/babelquarto)
