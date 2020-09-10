#!/usr/bin/env python3
'''
Python setuptools script to build and install the module 'libcolgraph'
'''

import setuptools
from setuptools import setup, Extension
from setuptools.command.build_py import build_py as _build_py
from setuptools.command.build_ext import build_ext as _build_ext


class build_py(_build_py):
    '''
    redefine the setuptools build cmd to build external module(s) first
    '''
    def run(self):            
        self.run_command('build_ext')
        return super().run()
        
class build_ext(_build_ext):
    '''
    redefine setuptools build_ext command to remove unncessary warning for C++
    '''
    def build_extensions(self):
        if '-Wstrict-prototypes' in self.compiler.compiler_so:
            self.compiler.compiler_so.remove('-Wstrict-prototypes')
        super().build_extensions()

libcolgraph_cpp_module = \
        Extension('libcolgraph._libcolgraph',
                  sources=['libcolgraph/libcolgraph.i',
                           'libcolgraph/Graph.cpp',
                           'libcolgraph/Vertex.cpp'],
                  include_dirs = ['libcolgraph/*.h',
                                  'libcolgraph/swigsources/*'],
                  swig_opts=['-c++'],
                  extra_compile_args=['-std=gnu++11'])
                            

with open('README.md', 'r') as readme:
    long_description = readme.read()

setup(name='libcolgraph',
      cmdclass = {'build_py': build_py, 'build_ext': build_ext},
      ext_modules=[libcolgraph_cpp_module],
      py_modules=['libcolgraph',
                  'libcolgraph.libcolgraph',
                  'libcolgraph.graphics',
                  'libcolgraph.web',
                  'libcolgraph.conjecture',],
      entry_points = {
        'console_scripts': ['colgraphweb = libcolgraph.web.__main__:main',
                            'libcolgraphweb = libcolgraph.web.__main__:main',
                            'lcgweb = libcolgraph.web.__main__:main',
                            'libcolgraph = libcolgraph.__main__:main'],
      },
      packages = setuptools.find_packages(),
      include_package_data=True,
      package_data={'web': ['*.html', '*.css', '*.js', 'public/']},
      version='0.0.7', #VERSION #TODO
      description='this library provides support to construct graphs and their '
                  'coloring graphs. a coloring graph is a metagraph '
                  'representing all the valid colorings of a graph. each '
                  'vertex of a coloring graph represents a coloring of the '
                  'base graph.',
      long_description=long_description,
      long_description_content_type="text/markdown",
      url='https://github.com/aalok-sathe/libcolgraph.git',
      author='Coloring Graphs lab, Univeristy of Richmond',
      author_email='aalok.sathe@richmond.edu',
      license='LGPL-3',
      install_requires = [
        'coloredlogs',
        'matplotlib',
        'cycler',
        'Flask',
        'networkx',
        'PySimpleGUI',
        'pdoc3',
      ], 
      python_requires='>=3.4',
      classifiers=[
          'Intended Audience :: Education',
          'Intended Audience :: Science/Research',
          'License :: OSI Approved :: GNU Lesser General Public License v3 '
                                      'or later (LGPLv3+)',
          'Programming Language :: Python :: 3.5',
          'Topic :: Software Development :: Libraries :: Python Modules'])
          
          
