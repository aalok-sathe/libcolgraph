#!/usr/bin/env python3

# stdlib
import argparse
from collections import defaultdict
from pathlib import Path


if __name__ == '__main__':
    public = Path(__file__).parent/'..'/'public'
    public = public.resolve()

    helptxt = '''
        Hi there, welcome to libcolgraph!
        (C) 2017-2020 Coloring Graphs lab, University of Richmond.
        GNU Lesser General Public License (LGPL) version 3 or later.
        Multiple contributors.
        
        ''' + 'Homepage: file://{}/index.html'.format(public) + '''
        
        To launch the interactive web interface, use `python3 -m libcolgraph.web [-h]`.
        '''
    print(helptxt)
