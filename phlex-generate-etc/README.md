## Setup
In a terminal, run `apptainer exec /opt/images/phaindia-0.1-20261002.sif ./build.sh`.

This will checkout a fork/branch from the author of the tutorial into this directory and
will build within build-phlex-examples.

The notebooks in `generate/`, `transport/`, and `drift/` will make use of that build directory.