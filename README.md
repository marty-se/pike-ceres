# pike-ceres
Pike glue for the Ceres Solver.

A shared Ceres library (libceres.so) is currently needed to build this module. See http://ceres-solver.org/building.html

Building the module should simply be a matter of running "pike -x module" in the module directory.

Run "pike -x module install" as root to install the resulting module in Pike's global library directory. An alternative is "pike -x module local_install" to install in the current user's local library directory (usually ~/lib/pike/modules/).
