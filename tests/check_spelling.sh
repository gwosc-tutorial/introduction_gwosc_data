#!/usr/bin/env bash

# This script checks spelling in a notebook (thanks to codespell).
# To do so, we remove the output (to avoid many false positive) and use codespell
# TODO: should we recode this in python (with the nbconvert API)?

set -e
set -u
set -o pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

ROOT_DIR=$(dirname "${SCRIPT_DIR}")
WORKING_DIR="${ROOT_DIR}/tmp/"

function print_usage()
{
    pg=$(basename $0)
    echo "Usage: $0 [-h] [-k] notebook"
    echo "Spellcheck notebook"
    echo "Options:"
    echo "  -h: print this help"
    echo "  -k: keep the script after execution"
    echo "Arguments:"
    echo "  notebook: notebook to check"
}


# CLI
HELP=false
KEEP=false
while getopts ":hk" Option
do
    case $Option in
        h ) HELP="true";;
        k ) KEEP="true";;
    esac
done
shift $(($OPTIND - 1))

if [[ "${HELP}" == "true" ]]
then
    print_usage
    exit 0
fi

# Get the file to check
# We need the real path as we will change directory
if [ $# -gt 0 ]
then
    file=$(realpath "$1")
else
    echo "No input notebook provided" >&2
    print_usage >&2
    exit 1
fi

# Now change directory
cd "${WORKING_DIR}"

# Remove output and spellcheck
# Record potential problems to report them

# The output file must end in .ipynb (otherwise, jupyter adds it).
# As macOS doesn't support the --sufix option, we don't create the file,
# just forge its name.
# There is a slight risk of collision here.
out_file=$(mktemp -u -p ${WORKING_DIR} tmp.XXXX).ipynb
log_file=$(mktemp -p ${WORKING_DIR})
set +e
jupyter nbconvert --to notebook --ClearOutputPreprocessor.enabled=True "${file}" --output "${out_file}" 1> "${log_file}" 2>&1
codespell -I "${ROOT_DIR}/.dictionary.txt" "${out_file}" 1>> "${log_file}" 2>&1
return_code=$?
set -e
if [[ "${return_code}" -ne 0 ]]
then
    echo "Spelling error in ${file}."
    echo "Return code: ${return_code}. Log:"
    cat "${log_file}"
else
    echo "No spelling error found in ${file}"
fi

# Clean
if [[ "${KEEP}" != "true" ]]
then
    rm "${out_file}" "${log_file}"
fi

exit "${return_code}"
