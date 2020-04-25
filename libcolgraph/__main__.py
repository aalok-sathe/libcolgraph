#!/usr/bin/env python3

# stdlib
import argparse
from collections import defaultdict
from pathlib import Path


def main():
    try:
        public = Path(__file__).parent/'..'/'public'
        public = public.resolve()
        public = 'file://{}/index.html'.format(public)
    except FileNotFoundError as e:
        public = 'https://aalok-sathe.gitlab.io/libcolgraph'

    helptxt = '''
        Hi there, welcome to libcolgraph!
        (C) 2017-2020 Coloring Graphs lab, University of Richmond.
        GNU Lesser General Public License (LGPL) version 3 or later.
        Multiple contributors.
        
        ''' + 'Homepage: {}'.format(public) + '''
        
        To launch the interactive web interface, use `python3 -m libcolgraph.web [-h]`.
        '''
    print(helptxt)
    

if __name__ == '__main__':
    main()
