/* template_defs.i */


%import "GraphTemplates.h"

%include "typemaps.i"
%include "std_vector.i"

%template(_IntVector) std::vector<int>;
%template(_LongVector) std::vector<long>;
%template(_IntVectorVector) std::vector<std::vector<int> >;

%template(_BaseGraphVertexIterator) GraphVertexIterator<BaseVertex>;
%template(_ColoringGraphVertexIterator) GraphVertexIterator<ColoringVertex>;
%template(_MetaGraphVertexIterator) GraphVertexIterator<MetaVertex>;
%template(_BaseVertexNeighborIterator) VertexNeighborIterator<BaseVertex>;
%template(_ColoringVertexNeighborIterator) VertexNeighborIterator<ColoringVertex>;
%template(_MetaVertexNeighborIterator) VertexNeighborIterator<MetaVertex>;
%template(_BaseGraph) Graph<BaseVertex>;
%template(_ColoringGraph) Graph<ColoringVertex>;
%template(_MetaGraph) Graph<MetaVertex>;

%include "GraphTemplates.h"
%include "Graph.h"
%include "Vertex.h"
