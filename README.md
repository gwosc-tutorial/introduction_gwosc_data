# Introduction to GWOSC Data

Welcome to the "Introduction to GWOSC Data" tutorials.
The tutorials will show you how to find, download and read gravitationnal wave data
accessible through the [Gravitational Wave Open Science Center](https://gwosc.org) (GWOSC).

The tutorials come as Jupyter notebooks and use the Python language.
Don't hesitate to extract part of the notebooks in your own scripts.

Each notebook illustrates a particular aspect of working with GWOSC data:

  - [Notebook 1](<01 - Download GWOSC Data.ipynb>) explains how to download data from the GWOSC website.
  - [Notebook 2](<02 - What's in a GWOSC Data File.ipynb>) presents details about reading the content of a file.
  - [Notebook 3](<03 - Working with Data Quality.ipynb>) presents quality flags, an important concept when working with gravitational wave data.
  - [Notebook 4](<04 - Working in the Frequency Domain.ipynb>) presents another important concept for gravitational wave data, the frequency domain.
  - [Notebook 5](<05 - GWpy Examples.ipynb>) presents a higher-level interface that hides many details to provide an easier access to the data.

We suggest 2 approaches to those notebooks:

  - if you want to understand the details about gravitationnal wave data, simply run the tutorials in order
  - if you're comfortable with gravitational wave data and don't want to bother about the details, go directly to notebook 5

## How to run the notebooks?

There are several possibilities to run the notebooks.
If you're not familiar with the notebook interface, take some time to read [this introduction](https://jupyter.org/try-jupyter/notebooks/?path=notebooks/Intro.ipynb) (on the page that opens click on "Start now" in the lower right corner).

### Option 1 (easy): run on Binder

[Binder](https://mybinder.org/) is a free service to run notebooks in your browser.
It's the simplest option since you won't have to install anything or change the notebooks.
However, note that you will loose your work if you close your browser.

To use it, simply click on the following badge: [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/gwosc-tutorial/introduction_gwosc_data/main).
This will open a workspace where you can open the notebooks and run them.

<div class="alert alert-block alert-warning">
<div><b>&#9888; Warning</b></div>
Binder may take a long time to start or even fail to start for some users.
If the service doesn't work for you, try another option.
</div>

### Option 2 (easy): run on Google Colab

[Google Colab](https://colab.research.google.com/) is another service to run notebooks in your browser.
As with Binder, you will loose your work if you close your browser.
If you are not familiar with Google Colab, you can beforehand take a look at the guides offered by Google at [this link](https://colab.research.google.com/notebooks/) (see the "Examples" tab).

To use it, simply click on the following badge: [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/gwosc-tutorial/introduction_gwosc_data/blob/main).
You can then choose a notebook and open it.
To open another notebook, re-click on the badge above and choose it.

<div class="alert alert-block alert-warning">
<div><b>&#9888; Warning</b></div>
For technical reasons, you need to run specific code if you use Google Colab.
This code is placed in the first cell of the notebooks and commented out.
You have to uncomment it and run the cell before running other cells.
</div>

### Option 3 (intermediate): run on your computer with conda

Another option for more advanced users is to clone the git repo and create a [conda](https://anaconda.org/) environment to install the required software.
It requires some level of familiarity with the terminal but allows more control since everything runs on your computer.
If you are not familiar with conda, read [here](https://docs.conda.io/projects/conda/en/latest/user-guide/index.html).

Once `conda` is installed, open a terminal and follow these instructions:

```bash
# Clone the repo and jump in the directory
git clone https://github.com/gwosc-tutorial/introduction_gwosc_data
cd introduction_gwosc_data
# Create the environment from the environment.yml file and activate it
conda env create --file environment.yml
conda activate introduction_gwosc_data
# Start jupyter lab server
jupyter-lab
```

The last step will open a workspace in your browser from which you can open the notebooks and run them.
To shutdown the server, hit `Ctrl+C` in the terminal.

If you want to work again on the notebooks, you don't need to redo all the instructions.
Instead, you can just:

```bash
cd introduction_gwosc_data
# Activate the environment
conda activate introduction_gwosc_data
# Start jupyter lab server
jupyter-lab
```

## How to go further?

The last notebook suggests other tutorials and resources to continue your journey.

If you have further questions, connect with the gravitational-wave community on [ask.igwn.org](https://ask.igwn.org/).

If you have found an error or want to suggest an improvement,
don't hesitate to [contact us](https://gwosc.org/contact/) or [open an issue on the GitHub repository](https://github.com/gwosc-tutorial/introduction_gwosc_data/issues).
You may have a look at the [contribution how-to](Contributing.md).

## License

The content of the repository is under the GPL v3.0 or later (see the [LICENSE](LICENSE) file).
