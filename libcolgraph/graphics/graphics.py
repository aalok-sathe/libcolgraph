#! /bin/env/ python3

'''
libcolgraph.graphics

Summary
-------
a graphics submodule within libcolgraph for help with visualization.
includes methods to interoperate representation formats between this library
and the library Vis.JS that is used to render in a web interface. additionally
includes a matplotlib-based method to generate pictorial representations of
possible colors of a vertex using a piechart
'''

import json
import math
import random
import io
import urllib, base64
from functools import partial

import matplotlib; matplotlib.use('Agg')
from matplotlib import pyplot as plt

from libcolgraph.libcolgraph import *


COLOR2HEX = {
        'red': '#ef5350',
        'blue': '#039be5',
        'green': '#4caf50',
        'yellow': '#ffee58',
        'pink': '#f48fb1',
        'purple': '#673ab7',
        'brown': '#795548',
        'white': '#f5f5f5',
        'cyan': '#18ffff',
        'orange': '#ff9100',
        'grey': '#bdbdbd',
        'lightgreen': '#76ff03',
     }
'''a mapping from colorname to the hex color representation to render'''

def get_colors(allcolors=COLOR2HEX, 
               colororder=['yellow', 'green', 'purple', 'white', 'pink', 
                           'cyan', 'brown'],
               special={'red', 'blue'}):
    '''docstring'''
    
    colorarray = [c for c in allcolors if c not in special]
    random.shuffle(colorarray)
    colorarray.sort(key=lambda x: colororder.index(x) if colororder.count(x) 
                                                      else float('inf'))
    random.shuffle(colorarray[len(colororder):])
    
    return colorarray

COLORS = get_colors()
'''an array storing the colors in the order to be used for coloring vertices'''


def get_piechart(hexcolors):
    '''
    given a list of colors in hex, returns an equally spaced out piechart
    with all those colors
    
    Parameters
    ----------
    hexcolors : collection of hex color strings
        collection of colors to include in pie chart
        
    Returns
    -------
    str
        base64 encoded representation of the pie chart graphic
    '''
    plt.ioff()
    plt.pie([1 for _ in hexcolors], colors=[*sorted(hexcolors)], startangle=0,
            radius=2)

    # trick pyplot into saving a file in a buffer so we can use it later
    buffer = io.BytesIO()
    plt.savefig(buffer, format='png', transparent=True)
    plt.close('all')

    buffer.seek(0)
    # encode it in base64 as visJS needs it
    imgstr = base64.b64encode(buffer.read())
    datauri = 'data:image/png;base64,' + urllib.parse.quote(imgstr)

    return datauri


def _to_visjs(g, colordict={1: COLOR2HEX['blue'], 0: COLOR2HEX['red']},
             colorfn=None, **kwargs):
    '''
    given a Graph instance, returns a VisJS representation of it complete with
    size, color, and shape information for ready visualization
    
    Parameters
    ----------
    g: Graph
        an instance of Graph
    colordict: dict
        mapping between integers (returned by colorfn) and hex color strings
        
    Returns
    -------
    (list, list)
        tuple of nodes and edges lists, each containing a VisJS node or edge
        json description
    '''
    nodes = {}
    edges = {}

    for v in g.get_vertices():
        name = v.get_name()
        nodes[name] = {
                        'id': name,
                        'label': str(name),
                        'size': 32*math.pow(len(v), 1/3),
                        'group': str(len(v)),
                        'shape': 'dot',
                      }

        if colorfn and type(colorfn(v)) is str:
            nodes[name]['color'] = colordict[colorfn(v)]
            nodes[name]['label'] += ' ' + nodes[name]['color']
        elif 'Base' in str(type(g)):
            if colorfn and type(colorfn(v)) is list:
                nodes[name]['shape'] = 'image'
                nodes[name]['image'] = get_piechart([colordict[c]
                                                     for c in colorfn(v)])
            else:
                nodes[name]['shape'] = 'triangle'

        if hasattr(g, 'locations'):
            nodes[name]['x'], nodes[name]['y'] = g.locations[name]

        for n in v.get_neighbors():
            edge = tuple(sorted([name, n]))
            if edge in edges:
                continue

            edges[edge] = {
                            'from': edge[0],
                            'to': edge[1],
                            'id': '%d %d' % edge,
                            'value': (len(g.get_vertex(edge[0]))
                                      * len(g.get_vertex(edge[1]))) ** .5,
                            'color': {'inherit': 'both', 'opacity': .95},
                          }

    nodes = [v for k, v in nodes.items()]
    edges = [v for k, v in edges.items()]

    return nodes, edges


def to_visjs(g, force_type=None, 
             colordict={1: COLOR2HEX['blue'], 2: COLOR2HEX['red']},
             colorfn=lambda v: 1+int(len(v)==1), **kwargs):
    '''
    takes in a graph which is a subclass of Graph<> (see GraphTemplates.h)
    and produces a json object that specifies how the graph should be plotted
    in a way that VisJS can use. wraps a helper function to return a 'data'
    dictionary with deparate nodes and edges named appropriately for the kind
    of Graph instance of g
    '''

    nodes, edges = _to_visjs(g, colordict=colordict, colorfn=colorfn, **kwargs)

    prefix = ''
    typestr = str(type(g))
    # print(typestr)
    if not force_type:
        if 'Base' in typestr: prefix = 'bg'
        elif 'Coloring' in typestr: prefix = 'cg'
        else: prefix = 'mcg'
    else:
        prefix=force_type

    data = {prefix+'nodes': json.dumps(nodes),
            prefix+'edges': json.dumps(edges)}

    return data


def from_visjs(data, *args, **kwargs):
    '''
    takes in data generated by visJS and converts it to a BaseGraph object
    '''
    g = BaseGraph()

    lookup = dict()
    for i, node in enumerate(data):
        lookup[node['id']] = i
        g.add_vertex(i)

    for node in data:
        for nbr in node['connections']:
            g.make_edge(lookup[node['id']], lookup[str(nbr)])

    g.locations = dict()
    for node in data:
        g.locations[lookup[node['id']]] = (node['x'], node['y'])

    return g
    
    
