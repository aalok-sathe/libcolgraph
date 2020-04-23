
// File: index.xml

// File: classBaseGraph.xml


%feature("docstring") BaseGraph "
`BaseGraph()`  

Constructors
------------
* `BaseGraph()`  
";

%feature("docstring") BaseGraph::reset "
`reset()`  

resets the graph by clearing its hashed collection of vertices  
";

%feature("docstring") BaseGraph::get_vertex_color "
`get_vertex_color(long coloring, long name, int k) -> int`  
";

%feature("docstring") BaseGraph::get_vertices "
`get_vertices() -> const BaseGraphVertexIterator *`  
";

%feature("docstring") BaseGraph::is_valid_coloring "
`is_valid_coloring(long coloring, int k) -> bool`  
";

%feature("docstring") BaseGraph::add_vertex "
`add_vertex(long name)`  
";

%feature("docstring") BaseGraph::make_edge "
`make_edge(long a, long b)`  
";

%feature("docstring") BaseGraph::load_txt "
`load_txt(char *path)`  
";

%feature("docstring") BaseGraph::load_next_coloring "
`load_next_coloring(int current, int k, std::vector< int > &coloring)`  
";

%feature("docstring") BaseGraph::BaseGraph "
`BaseGraph()`  
";

%feature("docstring") BaseGraph::__iter__ "
`__iter__() -> const BaseGraphVertexIterator *`  
";

%feature("docstring") BaseGraph::find_all_colorings "
`find_all_colorings(int current, int k, ColoringGraph *cg, std::vector< int >
    coloring)`  
";

%feature("docstring") BaseGraph::build_coloring_graph "
`build_coloring_graph(int k) -> ColoringGraph *`  
";

%feature("docstring") BaseGraph::encode "
`encode(std::vector< int > &coloring, int k) -> long`  
";

// File: classBaseGraphVertexIterator.xml


%feature("docstring") BaseGraphVertexIterator "
`BaseGraphVertexIterator()`  
`BaseGraphVertexIterator(typename std::unordered_map< long, BaseVertex *
    >::iterator it_, long len_)`  

Constructors
------------
* `BaseGraphVertexIterator()`  

* `BaseGraphVertexIterator(typename std::unordered_map< long, BaseVertex *
    >::iterator it_, long len_)`  
";

%feature("docstring") BaseGraphVertexIterator::BaseGraphVertexIterator "
`BaseGraphVertexIterator()`  
`BaseGraphVertexIterator(typename std::unordered_map< long, BaseVertex *
    >::iterator it_, long len_)`  

Overloaded function
-------------------
* `BaseGraphVertexIterator()`  

* `BaseGraphVertexIterator(typename std::unordered_map< long, BaseVertex *
    >::iterator it_, long len_)`  
";

// File: classBaseVertex.xml


%feature("docstring") BaseVertex "
`BaseVertex()`  
`BaseVertex(long name_)`  

Constructors
------------
* `BaseVertex()`  

* `BaseVertex(long name_)`  

Attributes
----------
* `neighbors` : `std::unordered_set< long >`  

* `nt` : `BaseVertexNeighborIterator *`  
";

%feature("docstring") BaseVertex::add_neighbor "
`add_neighbor(Vertex &other)`  
";

%feature("docstring") BaseVertex::has_next_neighbor "
`has_next_neighbor() -> bool`  
";

%feature("docstring") BaseVertex::get_neighbors "
`get_neighbors() -> BaseVertexNeighborIterator *`  
";

%feature("docstring") BaseVertex::get_next_neighbor "
`get_next_neighbor() -> long`  
";

%feature("docstring") BaseVertex::reset_neighbor_track "
`reset_neighbor_track()`  
";

%feature("docstring") BaseVertex::__iter__ "
`__iter__() -> BaseVertexNeighborIterator *`  
";

%feature("docstring") BaseVertex::BaseVertex "
`BaseVertex()`  
`BaseVertex(long name_)`  

Overloaded function
-------------------
* `BaseVertex()`  

* `BaseVertex(long name_)`  
";

// File: classBaseVertexNeighborIterator.xml


%feature("docstring") BaseVertexNeighborIterator "
`BaseVertexNeighborIterator()`  
`BaseVertexNeighborIterator(std::unordered_set< long >::iterator it_, long
    len_)`  

Constructors
------------
* `BaseVertexNeighborIterator()`  

* `BaseVertexNeighborIterator(std::unordered_set< long >::iterator it_, long
    len_)`  

Attributes
----------
* `it` : `std::unordered_set< long >::iterator`  

* `len` : `long`  
";

%feature("docstring") BaseVertexNeighborIterator::BaseVertexNeighborIterator "
`BaseVertexNeighborIterator()`  
`BaseVertexNeighborIterator(std::unordered_set< long >::iterator it_, long
    len_)`  

Overloaded function
-------------------
* `BaseVertexNeighborIterator()`  

* `BaseVertexNeighborIterator(std::unordered_set< long >::iterator it_, long
    len_)`  
";

%feature("docstring") BaseVertexNeighborIterator::next "
`next() -> long`  
";

%feature("docstring") BaseVertexNeighborIterator::hasnext "
`hasnext() -> bool`  
";

// File: classColoringGraph.xml


%feature("docstring") ColoringGraph "
`ColoringGraph(int k, BaseGraph *bg)`  

Constructors
------------
* `ColoringGraph(int k, BaseGraph *bg)`  

Attributes
----------
* `colors` : `const int`  

* `base` : `BaseGraph *`  

* `precompexp` : `std::vector< std::vector< long > >`  
";

%feature("docstring") ColoringGraph::get_possible_colors "
`get_possible_colors(std::vector< long > vertexgroup) -> std::vector<
    std::vector< int > >`  
";

%feature("docstring") ColoringGraph::is_isomorphic "
`is_isomorphic(long a, long b) -> bool`  
";

%feature("docstring") ColoringGraph::add_vertex "
`add_vertex(long name)`  
";

%feature("docstring") ColoringGraph::__iter__ "
`__iter__() -> const ColoringGraphVertexIterator *`  
";

%feature("docstring") ColoringGraph::get_vertices "
`get_vertices() -> const ColoringGraphVertexIterator *`  
";

%feature("docstring") ColoringGraph::tarjans "
`tarjans() -> MetaGraph *`  
";

%feature("docstring") ColoringGraph::ColoringGraph "
`ColoringGraph(int k, BaseGraph *bg)`  
";

// File: classColoringGraphVertexIterator.xml


%feature("docstring") ColoringGraphVertexIterator "
`ColoringGraphVertexIterator()`  
`ColoringGraphVertexIterator(typename std::unordered_map< long, ColoringVertex *
    >::iterator it_, long len_)`  

Constructors
------------
* `ColoringGraphVertexIterator()`  

* `ColoringGraphVertexIterator(typename std::unordered_map< long, ColoringVertex
    * >::iterator it_, long len_)`  
";

%feature("docstring") ColoringGraphVertexIterator::ColoringGraphVertexIterator "
`ColoringGraphVertexIterator()`  
`ColoringGraphVertexIterator(typename std::unordered_map< long, ColoringVertex *
    >::iterator it_, long len_)`  

Overloaded function
-------------------
* `ColoringGraphVertexIterator()`  

* `ColoringGraphVertexIterator(typename std::unordered_map< long, ColoringVertex
    * >::iterator it_, long len_)`  
";

// File: classColoringVertex.xml


%feature("docstring") ColoringVertex "
`ColoringVertex(long name_, int k, ColoringGraph *graph_)`  

Constructors
------------
* `ColoringVertex(long name_, int k, ColoringGraph *graph_)`  

Attributes
----------
* `colors` : `const int`  

* `graph` : `ColoringGraph *`  

* `nt` : `ColoringVertexNeighborIterator *`  
";

%feature("docstring") ColoringVertex::get_next_neighbor "
`get_next_neighbor() -> long`  
";

%feature("docstring") ColoringVertex::get_neighbors "
`get_neighbors() -> ColoringVertexNeighborIterator *`  
";

%feature("docstring") ColoringVertex::__iter__ "
`__iter__() -> ColoringVertexNeighborIterator *`  
";

%feature("docstring") ColoringVertex::reset_neighbor_track "
`reset_neighbor_track()`  
";

%feature("docstring") ColoringVertex::ColoringVertex "
`ColoringVertex(long name_, int k, ColoringGraph *graph_)`  
";

%feature("docstring") ColoringVertex::has_next_neighbor "
`has_next_neighbor() -> bool`  
";

// File: classColoringVertexNeighborIterator.xml


%feature("docstring") ColoringVertexNeighborIterator "
`ColoringVertexNeighborIterator()`  
`ColoringVertexNeighborIterator(long name_, int colors_, ColoringGraph *graph_)`  

Constructors
------------
* `ColoringVertexNeighborIterator()`  

* `ColoringVertexNeighborIterator(long name_, int colors_, ColoringGraph
    *graph_)`  

Attributes
----------
* `name` : `long`  

* `colors` : `int`  

* `graph` : `ColoringGraph *`  

* `outerpos` : `int`  

* `positionctr` : `int`  

* `colorctr` : `int`  
";

%feature("docstring") ColoringVertexNeighborIterator::next "
`next() -> long`  
";

%feature("docstring") ColoringVertexNeighborIterator::ColoringVertexNeighborIterator "
`ColoringVertexNeighborIterator()`  
`ColoringVertexNeighborIterator(long name_, int colors_, ColoringGraph *graph_)`  

Overloaded function
-------------------
* `ColoringVertexNeighborIterator()`  

* `ColoringVertexNeighborIterator(long name_, int colors_, ColoringGraph
    *graph_)`  
";

%feature("docstring") ColoringVertexNeighborIterator::hasnext "
`hasnext() -> bool`  
";

// File: classGraph.xml


%feature("docstring") Graph "

Attributes
----------
* `vertices` : `std::unordered_map< long, V * >`  
    stores a mapping of vertex names to pointers to vertex instances. in case of
    `BaseGraph` and `MetaGraph`, it is simply the numeric id of the vertex. in
    case of `ColoringGraph`, it is the encoded coloring of some `BaseGraph`  

* `connected` : `bool`  

* `biconnected` : `bool`  
";

%feature("docstring") Graph::Graph "
`Graph()`  
";

%feature("docstring") Graph::tarjans "
`tarjans() -> MetaGraph *`  
";

%feature("docstring") Graph::is_connected "
`is_connected() -> bool`  
";

%feature("docstring") Graph::get_vertices "
`get_vertices()=0 -> const GraphVertexIterator< V > *`  
";

%feature("docstring") Graph::load_txt "
`load_txt(char *path)`  
";

%feature("docstring") Graph::add_vertex "
`add_vertex(long name)=0`  
";

%feature("docstring") Graph::~Graph "
`~Graph()`  
";

%feature("docstring") Graph::is_biconnected "
`is_biconnected() -> bool`  
";

%feature("docstring") Graph::size "
`size() -> long`  
";

%feature("docstring") Graph::save_txt "
`save_txt()`  
";

%feature("docstring") Graph::__iter__ "
`__iter__()=0 -> const GraphVertexIterator< V > *`  
";

%feature("docstring") Graph::get_vertex "
`get_vertex(long name) -> V &`  
";

%feature("docstring") Graph::get_some_vertex "
`get_some_vertex() -> V &`  
";

// File: classGraphVertexIterator.xml


%feature("docstring") GraphVertexIterator "

Attributes
----------
* `it` : `std::unordered_map< long, V * >::iterator`  

* `len` : `long`  
";

%feature("docstring") GraphVertexIterator::hasnext "
`hasnext() -> bool`  
";

%feature("docstring") GraphVertexIterator::~GraphVertexIterator "
`~GraphVertexIterator()`  
";

%feature("docstring") GraphVertexIterator::next "
`next() -> V`  
";

%feature("docstring") GraphVertexIterator::__next__ "
`__next__() -> V`  
";

%feature("docstring") GraphVertexIterator::__iter__ "
`__iter__() -> GraphVertexIterator< V > *`  
";

%feature("docstring") GraphVertexIterator::GraphVertexIterator "
`GraphVertexIterator()`  
`GraphVertexIterator(typename std::unordered_map< long, V * >::iterator it_,
    long len_)`  

Overloaded function
-------------------
* `GraphVertexIterator()`  

* `GraphVertexIterator(typename std::unordered_map< long, V * >::iterator it_,
    long len_)`  
";

// File: classMetaGraph.xml


%feature("docstring") MetaGraph "
`MetaGraph()`  

Constructors
------------
* `MetaGraph()`  

Attributes
----------
* `colors` : `int`  

* `base` : `BaseGraph *`  

* `cut_vertices` : `std::unordered_set< long >`  

* `unique_cut_vertices` : `std::unordered_set< long >`  

* `mothership_cut_vertices` : `std::unordered_set< long >`  
";

%feature("docstring") MetaGraph::get_vertices "
`get_vertices() -> const MetaGraphVertexIterator *`  
";

%feature("docstring") MetaGraph::identify_mothership "
`identify_mothership() -> long`  
";

%feature("docstring") MetaGraph::add_vertex "
`add_vertex(long name)`  
`add_vertex() -> MetaVertex *`  

Overloaded function
-------------------
* `add_vertex(long name)`  

* `add_vertex() -> MetaVertex *`  
";

%feature("docstring") MetaGraph::rebuild_partial_graph "
`rebuild_partial_graph() -> ColoringGraph *`  
";

%feature("docstring") MetaGraph::MetaGraph "
`MetaGraph()`  
";

%feature("docstring") MetaGraph::get_cut_vertices "
`get_cut_vertices() -> const MetaGraphCutVertexIterator *`  
";

%feature("docstring") MetaGraph::__iter__ "
`__iter__() -> const MetaGraphVertexIterator *`  
";

%feature("docstring") MetaGraph::remove_vertex "
`remove_vertex(MetaVertex *m)`  
";

%feature("docstring") MetaGraph::get_mothership_cut_vertices "
`get_mothership_cut_vertices() -> const MetaGraphCutVertexIterator *`  
";

%feature("docstring") MetaGraph::_DFS_and_add "
`_DFS_and_add(ColoringGraph *cg, ColoringGraph *itercg, long name,
    std::unordered_set< long > &mothership)`  
";

// File: classMetaGraphCutVertexIterator.xml


%feature("docstring") MetaGraphCutVertexIterator "
`MetaGraphCutVertexIterator()`  
`MetaGraphCutVertexIterator(std::unordered_set< long >::iterator it_, long
    len_)`  

Constructors
------------
* `MetaGraphCutVertexIterator()`  

* `MetaGraphCutVertexIterator(std::unordered_set< long >::iterator it_, long
    len_)`  
";

%feature("docstring") MetaGraphCutVertexIterator::MetaGraphCutVertexIterator "
`MetaGraphCutVertexIterator()`  
`MetaGraphCutVertexIterator(std::unordered_set< long >::iterator it_, long
    len_)`  

Overloaded function
-------------------
* `MetaGraphCutVertexIterator()`  

* `MetaGraphCutVertexIterator(std::unordered_set< long >::iterator it_, long
    len_)`  
";

// File: classMetaGraphVertexIterator.xml


%feature("docstring") MetaGraphVertexIterator "
`MetaGraphVertexIterator()`  
`MetaGraphVertexIterator(typename std::unordered_map< long, MetaVertex *
    >::iterator it_, long len_)`  

Constructors
------------
* `MetaGraphVertexIterator()`  

* `MetaGraphVertexIterator(typename std::unordered_map< long, MetaVertex *
    >::iterator it_, long len_)`  
";

%feature("docstring") MetaGraphVertexIterator::MetaGraphVertexIterator "
`MetaGraphVertexIterator()`  
`MetaGraphVertexIterator(typename std::unordered_map< long, MetaVertex *
    >::iterator it_, long len_)`  

Overloaded function
-------------------
* `MetaGraphVertexIterator()`  

* `MetaGraphVertexIterator(typename std::unordered_map< long, MetaVertex *
    >::iterator it_, long len_)`  
";

// File: classMetaVertex.xml


%feature("docstring") MetaVertex "
`MetaVertex(long name_)`  

Constructors
------------
* `MetaVertex(long name_)`  

Attributes
----------
* `neighbors` : `std::unordered_set< long >`  

* `vertices` : `std::unordered_set< long >`  

* `nt` : `MetaVertexNeighborIterator *`  

* `identity` : `long`  
";

%feature("docstring") MetaVertex::add_neighbor "
`add_neighbor(MetaVertex &other)`  
";

%feature("docstring") MetaVertex::has_next_neighbor "
`has_next_neighbor() -> bool`  
";

%feature("docstring") MetaVertex::connect "
`connect(MetaVertex *v)`  
";

%feature("docstring") MetaVertex::get_next_neighbor "
`get_next_neighbor() -> long`  
";

%feature("docstring") MetaVertex::reset_neighbor_track "
`reset_neighbor_track()`  
";

%feature("docstring") MetaVertex::__iter__ "
`__iter__() -> MetaVertexNeighborIterator *`  
";

%feature("docstring") MetaVertex::get_neighbors "
`get_neighbors() -> MetaVertexNeighborIterator *`  
";

%feature("docstring") MetaVertex::get_vertices "
`get_vertices() -> MetaVertexStoredVerticesIterator *`  
";

%feature("docstring") MetaVertex::disconnect "
`disconnect(MetaVertex *v)`  
";

%feature("docstring") MetaVertex::~MetaVertex "
`~MetaVertex()`  
";

%feature("docstring") MetaVertex::size "
`size() -> int`  
";

%feature("docstring") MetaVertex::MetaVertex "
`MetaVertex(long name_)`  
";

// File: classMetaVertexNeighborIterator.xml


%feature("docstring") MetaVertexNeighborIterator "
`MetaVertexNeighborIterator()`  
`MetaVertexNeighborIterator(std::unordered_set< long >::iterator it_, long
    len_)`  

Constructors
------------
* `MetaVertexNeighborIterator()`  

* `MetaVertexNeighborIterator(std::unordered_set< long >::iterator it_, long
    len_)`  

Attributes
----------
* `it` : `std::unordered_set< long >::iterator`  

* `len` : `long`  
";

%feature("docstring") MetaVertexNeighborIterator::MetaVertexNeighborIterator "
`MetaVertexNeighborIterator()`  
`MetaVertexNeighborIterator(std::unordered_set< long >::iterator it_, long
    len_)`  

Overloaded function
-------------------
* `MetaVertexNeighborIterator()`  

* `MetaVertexNeighborIterator(std::unordered_set< long >::iterator it_, long
    len_)`  
";

%feature("docstring") MetaVertexNeighborIterator::next "
`next() -> long`  
";

%feature("docstring") MetaVertexNeighborIterator::hasnext "
`hasnext() -> bool`  
";

// File: classMetaVertexStoredVerticesIterator.xml


%feature("docstring") MetaVertexStoredVerticesIterator "
`MetaVertexStoredVerticesIterator(std::unordered_set< long >::iterator it_, long
    len_)`  

Constructors
------------
* `MetaVertexStoredVerticesIterator(std::unordered_set< long >::iterator it_,
    long len_)`  
";

%feature("docstring") MetaVertexStoredVerticesIterator::MetaVertexStoredVerticesIterator "
`MetaVertexStoredVerticesIterator(std::unordered_set< long >::iterator it_, long
    len_)`  
";

// File: classVertex.xml


%feature("docstring") Vertex "
`Vertex()`  
`Vertex(long name_)`  

Constructors
------------
* `Vertex()`  

* `Vertex(long name_)`  

Attributes
----------
* `name` : `long`  

* `depth` : `int`  

* `lowpoint` : `int`  

* `parent` : `std::list< long >::iterator`  
";

%feature("docstring") Vertex::reset_neighbor_track "
`reset_neighbor_track()=0`  
";

%feature("docstring") Vertex::get_name "
`get_name() const  -> long`  
";

%feature("docstring") Vertex::~Vertex "
`~Vertex()`  
";

%feature("docstring") Vertex::get_next_neighbor "
`get_next_neighbor()=0 -> long`  
";

%feature("docstring") Vertex::size "
`size() -> int`  
";

%feature("docstring") Vertex::has_next_neighbor "
`has_next_neighbor()=0 -> bool`  
";

%feature("docstring") Vertex::Vertex "
`Vertex()`  
`Vertex(long name_)`  

Overloaded function
-------------------
* `Vertex()`  

* `Vertex(long name_)`  
";

// File: classVertexNeighborIterator.xml


%feature("docstring") VertexNeighborIterator "
";

%feature("docstring") VertexNeighborIterator::hasnext "
`hasnext()=0 -> bool`  
";

%feature("docstring") VertexNeighborIterator::__next__ "
`__next__() -> long`  
";

%feature("docstring") VertexNeighborIterator::__iter__ "
`__iter__() -> VertexNeighborIterator< V > *`  
";

%feature("docstring") VertexNeighborIterator::next "
`next()=0 -> long`  
";

%feature("docstring") VertexNeighborIterator::~VertexNeighborIterator "
`~VertexNeighborIterator()`  
";

%feature("docstring") VertexNeighborIterator::VertexNeighborIterator "
`VertexNeighborIterator()`  
";

// File: Graph_8cpp.xml

// File: Graph_8h.xml

// File: GraphTemplates_8h.xml

// File: Vertex_8cpp.xml

// File: Vertex_8h.xml

// File: dir_295052479fd28a1b79ac53d24c433ab8.xml

