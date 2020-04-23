
'''
libcolgraph.web


Usage
-----
    libcolgraph.web [-h] [-i INPUT_FILE] [-n] [-s] [-k COLORS] [-v] [-p PORT]
                       [-w] [-r] [-d] [-t]

    optional arguments:
      -h, --help            show this help message and exit
      -i INPUT_FILE, --input-file INPUT_FILE
                            read in BaseGraph from adjacency matrix file
      -n, --new             open a blank canvas?
      -s, --select_file     open file choosing gui dialogue?
      -k COLORS, --colors COLORS
                            number of colors to use to create ColoringGraph
      -v, --verbosity       set output verbosity
      -p PORT, --port PORT  port to launch GUI on
      -w, --webbrowser      open app in default web browser window?
      -r, --render_on_launch
                            render to-generate componenets on initial launch?
      -d, --debug           launch Flask app in debug mode?
      -t, --threaded        allow multiple threads?
'''

from .web import *
