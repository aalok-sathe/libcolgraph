/* cpp_inline.i */

%{
    #include <Python.h>
    #include <assert.h>
    #include <stdexcept>
    #include <iostream>
    #include <vector>
    #include <unordered_set>

    #include "GraphTemplates.h"
    #include "Graph.h"
    #include "Vertex.h"
%}
