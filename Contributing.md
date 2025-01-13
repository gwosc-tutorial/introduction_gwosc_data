# How to contribute to the tutorials?

This document describes how to contribute to the tutorials.
It also contains guidelines about how to format the notebooks.

We assume you have a basic knowledge of `git` and GitHub.
If it's not the case, read the [GitHub tutorials](https://docs.github.com/en/get-started).

We also assume basic familiarity with Jupyter notebooks.
If it's not the case, read [this introduction](https://jupyter.org/try-jupyter/notebooks/?path=notebooks/Intro.ipynb).

## Contribution workflow

The workflow to contribute is based on GitHub.

The first thing to do if you want to improve the tutorials is to open an issue on GitHub to describe your idea.
An issue can be about anything from a simple typo to larger improvements.
This issue will be used to discuss the best way to tackle the problem.

If you want to work on this issue, you will have to fork the repository in your GitHub account,
create a branch and open a pull request once the modification is done.

## Notebook formatting

The format of Jupyter notebooks is hard to version properly.
To ease reviews and merges, it's important that notebooks are written in a consistent way.
Here are some indications.

### Markdown formatting

Notebook for tutorials often contains explanatory text in addition to code.
When writing text always split different titles and paragraphs in different cells.
Also, use a newline for each sentence (Markdown is insensitive to this).

For instance, don't do:

![image](img/cells_bad.png)

Instead, do:

![image](img/cells_good.png)

The rendering is close but this helps when comparing versions.

### Store images in the img/ folder

If you want to include an image, store it in the folder `img/`.

### Use relative links for images and other notebooks

To insert links to an image or to another notebook in this repository,
use a relative link without any URL.

For instance, to add a link to a notebook, don't do:

```
See [this notebook](https://github.com/gwosc-tutorial/introduction_gwosc_data/My New Notebook.ipynb).
```

Instead, do:

```
See [this notebook](<./My New Notebook.ipynb>).
```

### Notes and warnings

To insert a note, use the following snippet:

```html
<div class="alert alert-block alert-info">
<div><b>&#x2139; Note</b></div>
    Your note.
</div>
```

To insert a warning, use the following snippet:

```html
<div class="alert alert-block alert-warning">
<div><b>&#9888; Warning</b></div>
    Your alert.
</div>
```

Such admonition should go in a separate cell.

## Other guidelines

### Re-run the notebook from scratch before committing

Before committing, it's good to re-run the notebook from scratch
as it allows to ensure that there is no bug
and to have nicely ordered cells.

To do so, open the "Run" menu and click "Restart Kernel and Run All Cells".

### Specific code for Google Colab

Google Colab is a service used to run notebooks in the browser without installation.
It is important to test your modifications on Google Colab.

However, the service has 2 technical limitations:

  - The notebooks are run in isolation.
    So if your modification needs the output from another notebook (such as a downloaded file, etc.)
    you have to provide a way to access it.
  - Only basic packages are installed.
    Therefore, your notebook should include calls to `pip` to install any additional packages.

This specific code should be placed in a dedicated cell near the top of the notebook
and commented out by default.
Also, add a warning before such cells.
Have look at [tutorial 5](<./05 - GWpy Examples.ipynb>) for an example.
