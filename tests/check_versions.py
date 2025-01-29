#!/usr/bin/env python

# Check that the versions installed in a notebook are the same than in the environment
# To do so we open the notebook and inspects the cells

import argparse
import json
import sys
import re
import yaml


# CLI
parser = argparse.ArgumentParser(
    description='Check that package installed in a notebook are the same than in the conda environment',
    formatter_class=argparse.ArgumentDefaultsHelpFormatter,
)
parser.add_argument('notebook')
parser.add_argument(
    '--env-file',
    help="Specify the environment file",
    default="environment.yml"
)

# Parse CLI
args = parser.parse_args()
fname = args.notebook
env_file = args.env_file

# Read in the environment yaml file
with open(env_file) as f:
    environment = yaml.load(f, Loader=yaml.loader.SafeLoader)

# Extract the dependencies and versions in environment
dependencies = {}
for element in environment["dependencies"]:
    module, version = element.split("=")
    dependencies[module] = version

# Detect pip installs in notebook and check that it's coherent with the environment
errors = []
with open(fname, "r") as file:
    content = json.load(file)
for cell in content["cells"]:
    code = "\n".join(cell["source"])
    if "pip install " in code:
        pip_installs = re.findall("([a-z]+==[0-9.]+)", code)
        for element in pip_installs:
            module, version = element.split("==")
            if module in dependencies:
                if dependencies[module] != version:
                    msg = f"Version mismatch for {module}: {fname} requires {version}, environment requires {dependencies[module]}"
                    errors.append(msg)
            else:
                msg = f"Missing module: {fname} needs {module}: {version}, but it is not in the {env_file} file"
                errors.append(msg)

if len(errors) > 0:
    errors = "\n".join(errors)
    msg =  f"Version issues in {fname}:\n"
    msg += f"{errors}"
    print(msg)
    sys.exit(1)
else:
    print(f"No version issue in {fname}")
    sys.exit(0)
