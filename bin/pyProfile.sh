#! /usr/bin/bash

python -m cProfile -o stat.prof $1
python -m ~/bin/gprof2dot -fMYSCRIPY.PY [ARGS...] pstats -o stat.dot stat.prof
dot -ostat.png -Tpng stat.dot
