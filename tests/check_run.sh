#!/usr/bin/env bash

# This script checks that a notebook execute properly.
# To do so, we export it to python and execute the script.
# The script is always executed in WORKING_DIR (see below).
# TODO: should we recode this in python (with the nbconvert API)?

set -e
set -u
set -o pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

ROOT_DIR=$(dirname "${SCRIPT_DIR}")
WORKING_DIR="${ROOT_DIR}/tmp/"

# This file is needed by some notebooks so the best option is to download it if needed
# We include the checksum to avoid incorrect downloads
DATA_FILE=H-H1_GWOSC_O3b_4KHZ_R1-1264312320-4096.hdf5
SHA512=51d21d438677e6750879824a12088dbff28fa7824cd10ee4fe42bedf24a9596cb53ed26c5416c386ba76cf0d8d2c24cf471505deaae8599c633afab2cfe81282

function print_usage()
{
    pg=$(basename $0)
    echo "Usage: $0 [-h] [-k] notebook"
    echo "Test execution of a notebook by exporting to a python script and running it"
    echo "Options:"
    echo "  -h: print this help"
    echo "  -k: keep the script after execution"
    echo "Arguments:"
    echo "  notebook: notebook to run"
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

# Download DATA_FILE
while [[ ! -f "${DATA_FILE}" && $(sha512sum "${DATA_FILE}" | awk '{print $1}') != "${SHA512}" ]]
do
    echo "Downloading data file"
    curl -L "http://gwosc.org/archive/data/O3b_4KHZ_R1/1263534080/${DATA_FILE}" -o "${DATA_FILE}"
done

# Convert the file to python and execute it
# Record potential problems to report them

# The output file must end in .py (otherwise, jupyter adds it).
# As macOS doesn't support the --sufix option, we don't create the file,
# just forge its name.
# There is a slight risk of collision here.
out_file=$(mktemp -u -p ${WORKING_DIR} tmp.XXXX).py
log_file=$(mktemp -p ${WORKING_DIR})
set +e
jupyter nbconvert --to python --RegexRemovePreprocessor.patterns="^%" "${file}" --output "${out_file}" 1> "${log_file}" 2>&1
python "${out_file}" 1>> "${log_file}" 2>&1
return_code=$?
set -e
if [[ "${return_code}" -ne 0 ]]
then
    echo "Execution error in ${file}."
    echo "Return code: ${return_code}. Log:"
    cat "${log_file}"
else
    echo "No execution error found in ${file}"
fi

# Clean
if [[ "${KEEP}" != "true" ]]
then
    rm "${out_file}" "${log_file}"
fi

exit "${return_code}"
