#!/usr/bin/env python3

'''
libcolgraph

## Summary

libcolgraph is a fast and memory-efficient library to manipulate graphs of
vertex colorings, 'coloring graphs'. 
libcolgraph has multiple members listed as 'submodules' below.

to use the library, simply import it: **```import libcolgraph```**. 

to use the web interface, type 
**```python3 -m libcolgraph.web```** (with ```-h``` for usage help).

for more info, visit the [home page](../index.html), 
where you will find helpful information and navigation options to the source code 
as well as a web-based demo of visualization.
'''

from libcolgraph.libcolgraph import *
from libcolgraph.graphics import graphics
from libcolgraph.web import web


__pdoc__ = {}
