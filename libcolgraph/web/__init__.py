
'''
libcolgraph.web


Web UI Tutorial
---------------
1. double click on a window to enlarge it; double click again to make it a large size; and yet again to restore to original
2. load a `BaseGraph` either via command line (see below) or using the 'load' button in the app
3. enter k= number of colors to color it with
4. hit 'generate' to generate graphs

you can toggle physics using a dedicated button. you can enable/disable window drag mode and move windows around to your
taste.


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
