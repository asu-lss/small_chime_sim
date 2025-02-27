# Example cylinder telescope simulation

This directory contains the ingredients to run a small CHIME simulation on your personal computer, considering only a small subset of baselines and frequencies in order to keep the runtime and output filesize manageable.

To run this simulation, you'll first need to set up a Python virtual environment on your computer.
- If on Windows, it is strongly recommended to do this within Windows Subsystem for Linux (https://learn.microsoft.com/en-us/windows/wsl/install), since the healpix library is incompatible with Windows.
- It is also strongly recommended to use the `mkchimeenv` script (https://github.com/chime-experiment/mkchimeenv/tree/main) to set up your virtual environment.
- Finally, if doing code development or testing, it is strongly recommeded to make sure that you can use MPI on your computer, because a wide class of bugs only appears when executing the code with MPI.

- As of Feb. 27, 2025, you'll need to checkout the `ar/offline-telescope` branch of `ch_pipeline` for the first step to work. (I.e. go to the `ch_pipeline` directory in your virtual environment directory and do `git checkout ar/offline-telescope`.)

This tutorial is likely to be infrequently updated and may break as `radiocosmology` packages or CHIME packages change with time. Please let Simon know if you encounter any issues!

## Generating telescope products

In `bt_smallchime.yaml`, edit `output_directory` so that it points to your own `btm_sim_example/sim_output/products/` directory, and also edit `venv` to point to your Python virtual environment directory. From the command line (and with your virtual environment activated), execute
```
mpirun -n N drift-makeproducts run bt_smallchime.yaml
```
where `N` denotes how many MPI tasks to use. You can also omit `mpirun -n N` to run in serial. This uses the `drift-makeproducts` script in `driftscan` to parse the YAML file and generate telescope beam transfer matrices. A successful computation will show `drift.core.manager: DONE GENERATING PRODUCTS` in the last line of the terminal output. When run with `N=8` on Simon's laptop (Apple M3 Pro, 18GB RAM), this takes around 1 minute and generates ~285MB of files.

## Generating simulated sky maps

Run `generate_input_maps.sh` from the command line. This will use `cora` to generate simulated 21cm and foreground maps inside `sim_output/cora_maps/`. A successful computation will generate 2 map files in this directory. On Simon's laptop, this takes around 30 seconds and generates ~54MB of files.

## Generating simulated visibilities

Edit the directories in `generate_sstream.sh`, and then run it from the command line. This uses the `caput-pipeline` script in `caput` to run through the tasks in `sstream.yaml`, which use your simulated sky maps and beam transfer matrices to generate simulated visibilities (a "sidereal stream"). On Simon's laptop, this takes around 7 seconds and generates ~104MB of files.

## Exploring the output

Go through `output_exploration.ipynb` to explore what you have generated.
