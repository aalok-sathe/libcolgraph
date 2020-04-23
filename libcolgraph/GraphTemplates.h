#ifndef __GRAPH_TEMPLATES_H__
#define __GRAPH_TEMPLATES_H__

#include <unordered_map>
#include <set>
#include <fstream>


// forward declarations
class Vertex;
class BaseVertex;
class ColoringVertex;
class MetaVertex;
template <typename V> class Graph;
class BaseGraph;
class ColoringGraph;
class MetaGraph;


// a base iterator class to support iteration over a Vertex's
// neighboring vertices. Assumes an instance of polymorphic Vertex.
// may be subclassed to specialize for particular kinds of vertices.
// must be subclassed and implemented for each new kind of Vertex you add
// to this program.
template <typename V>
class VertexNeighborIterator
{
    public:
        VertexNeighborIterator() {};
        virtual ~VertexNeighborIterator() {};

        virtual long next() = 0;
        virtual long __next__();

        virtual bool hasnext() = 0;

        virtual VertexNeighborIterator<V>* __iter__();
};


// a base iterator class to support iteration over a Graph<>'s
// vertices. Assumes an instance of polymorphic Graph class,
// and assumes that vertices are stored in an internal hashmap
// mapping long->Vertex-inherited objects
// must be subclassed to specialize for each of the particular kinds of graphs
// that are in the program, and for any new kind of Graphs you might add
template <typename V>
class GraphVertexIterator
{
    public:
        typename std::unordered_map<long, V*>::iterator it;
        long len;

        GraphVertexIterator<V>() {};
        GraphVertexIterator<V>(typename std::unordered_map<long, V*>::iterator it_,
                               long len_)
            : it(it_), len(len_) {};
        virtual ~GraphVertexIterator() {};

        virtual V next();
        virtual V __next__();

        virtual bool hasnext();

        virtual GraphVertexIterator<V>* __iter__();
};


// the OG Graph<> class. It is a pure virtual class so it cannot
// be instantiated. Some of the methods may need implementation
// depending on the purpose of the graph being subclassed, in
// order for the class to function.
// Maintains a hashmap of <long, Vertex*>, so each vertex must have
// a unique long-type name.
// Stores V objects which are instances of or subclassed from Vertex
// Supports iteration via GraphVertexIterator objects, making it
// easy to wrap the iterator as a standalone object in high-level
// languages such as Python
template <typename V>
class Graph
{
    public:
        /**
         * stores a mapping of vertex names to pointers to vertex instances. 
         * in case of `BaseGraph` and `MetaGraph`, it is simply the numeric id
         * of the vertex. in case of `ColoringGraph`, it is the encoded 
         * coloring of some `BaseGraph`
         */   
        std::unordered_map<long, V*> vertices;
        
        //
        bool connected = true;
        bool biconnected = true;

        Graph();
        virtual ~Graph();

        // load in data from a standard adjacency matrix format
        // text file
        virtual void load_txt(char* path) {};

        // TODO
        virtual void save_txt() {};

        // returns the size of the graph in terms of the number of vertices
        virtual long size();

        // getter methods for connected and biconnectedness
        // only valid after a run of Tarjans
        virtual bool is_connected() { return connected; };
        virtual bool is_biconnected() { return biconnected; };

        // adds a vertex with name `name` to Graph's vertices
        virtual void add_vertex(long name) = 0;

        // returns a vertex with name `name`by reference
        virtual V& get_vertex(long name);
        // returns some (any) vertex by reference. specifically, the
        // the first vertex it encounters when iterating over its vertex
        // list. expect no particular order. NOT a randomized method.
        virtual V& get_some_vertex();

        // returns an iterator over vertices as a GraphVertexIterator
        // object
        virtual const GraphVertexIterator<V>* __iter__() = 0;
        virtual const GraphVertexIterator<V>* get_vertices() = 0;

        // runs Tarjan's algorithm for biconnected components on Graph,
        // and constructs a MetaGraph from the result of the algorithm.
        // each cut vertex gets its own MetaVertex, and each component
        // also gets its own MetaVertex. The meta cut-vertices and the
        // meta component vertices are connected to indicate the cut
        // component. Can be run on any subclassed instance of Graph.
        // MetaGraph is a subclass of Graph as well, so it supports the
        // usual methods.
        virtual MetaGraph* tarjans();

};



#endif
