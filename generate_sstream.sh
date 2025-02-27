#!/bin/sh

export SIM_OUT_DIR=sim_output/
export VENV_DIR=/Users/sforeman/Dropbox/Research/CHIME/py/venv_2024_10/venv/

caput-pipeline template-run --var sim_out_dir=${SIM_OUT_DIR} --var venv_dir=${VENV_DIR} sstream.yaml

