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
| docs | Website build location |
| images | All standalone images, i.e. images not generated within a code chunk. Keep this organized! |
| qmd | All qmd files. We will come up with a naming convention. Nesting in subdirectories is an option. |
| scripts | Currently a layover from 2025. May delete. |
| style-sheets | Custom scss code. |

**Make sure your `.gitignore` file is properly configured. We don't want to see your `.Rproj.user` file, your `.DS_Store` file if you're on a mac, or any other hidden or personal files you may have in your directory :)**

## Authoring Content

### YAML

YAML is a serialized language comprised of key value pairs, in essence, this means spaces are significant. Key value pairs are seperated by a colon and space `: ` and indenting of additional arguments uses a tab. The entire thing is wrapped in three back dashes `---`. Now that we're using Quarto, things should be relatively simple, and all you need is a title.

```
---
title: page title
---
```

### Code Chunks

Quickly insert a code chunk with cmd + option + i (Mac) or (Someone with a PC fill in.)

Code cell options are set with `|# option`

```{r}
|# option

dat <- read.csv()
```

See detailed options [here](https://quarto.org/docs/reference/cells/cells-knitr.html).

### Callout boxes

Callout boxes are used for highlighting sections of text. Quarto has built in presets. See options and markup instructions [here](https://quarto.org/docs/authoring/callouts.html).

This is the delivery content for the pilot RDM Jumpstart, scheduled to run May 12-16, 2025.

## Git Etiquette

Suggested workflow.

* Conduct all of your work in a `branch`. Build in that branch to test.
* `add` and `commit` only the files you edit, but nothing in the `docs` directory.
* Switch to `main` and pull to ensure you're up to date with `remote`.
* `merge` your `branch` to `main`.
* Build the site.
* `add`, `commit`, `push`.
* Cross your fingers.

# Naming Convention

**TBD**

