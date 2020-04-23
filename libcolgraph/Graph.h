#ifndef __GRAPH_H__
#define __GRAPH_H__

#include <unordered_map>
#include <cstddef>
#include <stdexcept>
#include <iostream>
#include <fstream>
#include <algorithm>
#include <vector>
#include <list>
#include <stack>
#include "GraphTemplates.h"
#include "Vertex.h"


// forward declarations
class Vertex;
class BaseVertex;
class ColoringVertex;
class MetaVertex;
template <typename V> class Graph;
class BaseGraph;
class ColoringGraph;
class MetaGraph;

class MetaGraphCutVertexIterator;

// an iterator class subclassed from GraphVertexIterator to specifically
// support iteration over a BaseGraph's Vertices, i.e., BaseVertex objects
class BaseGraphVertexIterator : public GraphVertexIterator<BaseVertex>
{
    public:
        BaseGraphVertexIterator() {};
        // constructor that takes in an iterator over vertex map
        BaseGraphVertexIterator(typename std::unordered_map<long, BaseVertex*>::iterator it_, long len_)
            : GraphVertexIterator<BaseVertex>(it_, len_) {};
};


// an iterator class subclassed from GraphVertexIterator to specifically
// support iteration over a ColoringGraph's Vertices, i.e., ColoringVertex
class ColoringGraphVertexIterator : public GraphVertexIterator<ColoringVertex>
{
    public:
        ColoringGraphVertexIterator() {};
        // constructor that takes in an iterator over vertex map
        ColoringGraphVertexIterator(typename std::unordered_map<long, ColoringVertex*>::iterator it_, long len_)
            : GraphVertexIterator<ColoringVertex>(it_, len_) {};

};


// an iterator class subclassed from GraphVertexIterator to specifically
// support iteration over a MetaGraph's Vertices, i.e., MetaVertex
class MetaGraphVertexIterator : public GraphVertexIterator<MetaVertex>
{
    public:
        MetaGraphVertexIterator() {};
        MetaGraphVertexIterator(
                typename std::unordered_map<long, MetaVertex*>::iterator it_,
                long len_
            )
            : GraphVertexIterator<MetaVertex>(it_, len_) {};

        // MetaGraphVertexIterator* __iter__();
};


// class BaseGraph subclassed from a particular template instance of Graph,
// that for BaseVertex objects
class BaseGraph : public Graph<BaseVertex>
{
    public:
        // default constructor
        BaseGraph();

        // method that takes a path to a file containing an adjacency matrix
        // description of a graph
        void load_txt(char* path);

        // TODO method that creates a random graph at the current BaseGraph
        // instance using the Erdos-Reyni random graph model
        // int v: how many vertices the graph should have
        // double p: what probability to use while generating edges between
        // pairs of vertices
        // void generate_random(int v, double p);

        /**
         * resets the graph by clearing its hashed collection of vertices
         */
        void reset() { vertices.clear(); };

        // adds a vertex of supplied name to the vertex list
        void add_vertex(long name);
        // adds an edge between two vertices with supplied names
        void make_edge(long a, long b);

        // given a coloring encoding in base 10 and parameter k for how many
        // colors, tries to assign coloring to vertices and determines if
        // it is a valid coloring
        bool is_valid_coloring(long coloring, int k);

        // given a coloring encoding, the name of a vertex, and param k,
        // determines the color of the vertex with supplied name in this
        // encoding
        int get_vertex_color(long coloring, long name, int k);

        // builds a coloring graph with k colors for this graph
        ColoringGraph* build_coloring_graph(int k);

        // recursive method with backtracking that takes a particular coloring
        // sequence and explores possible colorings in a DFS manner
        void find_all_colorings(int current, int k, ColoringGraph* cg,
                                std::vector<int> coloring);

        // given a coloring sequence by reference, produces the next coloring
        // sequence in-place in the sequential order of the coloring DFS
        void load_next_coloring(int current, int k, std::vector<int>& coloring);

        // given a coloring sequence, produces the corresponding long encoding
        // in base K
        long encode(std::vector<int>& coloring, int k);

        // returns an iterator object pointer over this graph's vertices
        const BaseGraphVertexIterator* __iter__();
        const BaseGraphVertexIterator* get_vertices();
};


class ColoringGraph : public Graph<ColoringVertex>
{
    public:
        // private constant, the number of colors this coloring graph has
        const int colors;
        // stores a pointer to the graph that this graph was constructed from
        BaseGraph* base;
        // precompexp[p][c] --> c * (COLORS ** p)
        std::vector<std::vector<long> > precompexp;

        // preferred constructor
        ColoringGraph(int k, BaseGraph* bg);

        // adds a vertex with given name to this graph
        void add_vertex(long name);

        // determines whether two colorings belong to the same
        // isomorphism class in this coloring graph
        bool is_isomorphic(long a, long b);

        // given a list of vertices, for each base vertex computes the possible
        // colors it can take in the list of coloring vertices
        std::vector<std::vector<int> >
            get_possible_colors(std::vector<long> vertexgroup);

        // returns an iterator object pointer over this graph's vertices
        const ColoringGraphVertexIterator* __iter__();
        const ColoringGraphVertexIterator* get_vertices();

        MetaGraph* tarjans();
};


class MetaGraph : public Graph<MetaVertex>
{
    public:
        // private constant, the number of colors this coloring graph has
        int colors;
        // stores a pointer to the graph that this graph was constructed from
        BaseGraph* base;
        // stores found cut vertices
        std::unordered_set<long> cut_vertices;
        // stores unique cut vertices each representative of an isomorphism
        // class of cut vertices
        std::unordered_set<long> unique_cut_vertices;
        // which of the unique (single isomorphism class) cut vertices are
        // also in the mothership? useful for visualization to create a dummy
        // mothership node
        std::unordered_set<long> mothership_cut_vertices;

        // default constructor
        MetaGraph();

        void add_vertex(long name);
        MetaVertex* add_vertex();

        // removes vertex with
        void remove_vertex(MetaVertex* m);

        // returns an iterator object pointer over this graph's vertices
        const MetaGraphVertexIterator* __iter__();
        const MetaGraphVertexIterator* get_vertices();

        // iterator over cut vertices found by the metagraph
        const MetaGraphCutVertexIterator* get_cut_vertices();
        // iterator over unique cut vertices that are in the mothership
        const MetaGraphCutVertexIterator* get_mothership_cut_vertices();

        void _DFS_and_add(ColoringGraph* cg, ColoringGraph* itercg, long name,
                          std::unordered_set<long>& mothership);

        // TODO only makes to call this on MetaGraph constructed from a
        // ColoringGraph
        long identify_mothership();

        // construct a coloring graph with the mothership vertex/vertices left
        // out, so only the polyps/polyp-like components get reconstructed
        ColoringGraph* rebuild_partial_graph();
};




#endif
