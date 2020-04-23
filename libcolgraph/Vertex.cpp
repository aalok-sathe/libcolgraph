#ifndef __VERTEX_CPP__
#define __VERTEX_CPP__

#include <string>
#include <sstream>
#include "Vertex.h"

/*******************************************************************************
***************************** VERTEX *******************************************
*******************************************************************************/


Vertex::
Vertex(long name_)
    : name(name_), depth(-1), lowpoint(INT_MAX)//, parent(NULL)
{}

Vertex::
~Vertex()
{}


bool
Vertex::
operator==(const Vertex& other)
{
    return name == other.get_name();
}


long
Vertex::
get_name() const
{
    return name;
}


/*******************************************************************************
****************************** BASEVERTEX **************************************
*******************************************************************************/

BaseVertex::
BaseVertex(long name_)
    : Vertex(name_), nt(new BaseVertexNeighborIterator())
{}


void
BaseVertex::
add_neighbor(Vertex& other)
{
    neighbors.insert(other.get_name());
    delete nt;
    nt = new BaseVertexNeighborIterator(neighbors.begin(),
                                        (long)neighbors.size());
}

long
BaseVertex::
get_next_neighbor()
{
    return nt->next();
}

void
BaseVertex::
reset_neighbor_track()
{
    delete nt;
    nt = new BaseVertexNeighborIterator(neighbors.begin(),
                                        (long)neighbors.size());
}


bool
BaseVertex::
has_next_neighbor()
{
    return nt->hasnext();
}


BaseVertexNeighborIterator*
BaseVertex::
get_neighbors()
{
    return this->__iter__();
}


BaseVertexNeighborIterator*
BaseVertex::
__iter__()
{
    return new BaseVertexNeighborIterator(neighbors.begin(),
                                          (long)neighbors.size());
}


/*******************************************************************************
***************************** ColoringVertex ***********************************
*******************************************************************************/


ColoringVertex::
ColoringVertex(long name_, int k, ColoringGraph* graph_)
    : Vertex(name_), colors(k), graph(graph_)
{
    nt = new ColoringVertexNeighborIterator(name_, k, graph_);
}


long
ColoringVertex::
get_next_neighbor()
{
    return nt->next();
}


bool
ColoringVertex::
has_next_neighbor()
{
    return nt->hasnext();
}


void
ColoringVertex::
reset_neighbor_track()
{
    delete nt;
    nt = new ColoringVertexNeighborIterator(name, colors, graph);
}


ColoringVertexNeighborIterator*
ColoringVertex::
get_neighbors()
{
    return __iter__();
}


ColoringVertexNeighborIterator*
ColoringVertex::
__iter__()
{
    return new ColoringVertexNeighborIterator(name, colors, graph);
}


/*******************************************************************************
***************************** VertexNeighborIterator ***************************
*******************************************************************************/

template <typename V>
long
VertexNeighborIterator<V>::
__next__()
{
    return next();
}


template <typename V>
VertexNeighborIterator<V>*
VertexNeighborIterator<V>::
__iter__()
{
    return this;
}


/*******************************************************************************
*************************** BaseVertexNeighborIterator *************************
*******************************************************************************/


BaseVertexNeighborIterator::
BaseVertexNeighborIterator(std::unordered_set<long>::iterator it_, long len_)
    : it(it_), len(len_)
{}


long
BaseVertexNeighborIterator::
next()
{
    if (this->len--)
        return *this->it++;

    throw std::out_of_range("");
}


bool
BaseVertexNeighborIterator::
hasnext()
{
    return (this->len > 0);
}


/*******************************************************************************
********************** ColoringVertexNeighborIterator **************************
*******************************************************************************/


ColoringVertexNeighborIterator::
ColoringVertexNeighborIterator(long name_, int k, ColoringGraph* graph_)
    : name(name_), colors(k), graph(graph_)
{
    positionctr = 0;
    colorctr = 0;
    // remaining = graph->base->size() * colors;
}


long
ColoringVertexNeighborIterator::
next()
{
    for (; positionctr < graph->base->size(); positionctr++)
    {
        long newcoloring;
        int curcol;
        std::unordered_map<long, ColoringVertex*>::iterator it;
        long divisor = graph->precompexp[positionctr][1];

        for (; colorctr < colors; colorctr++)
        {
            curcol = (name / divisor) % colors;
            if (curcol == colorctr)
                continue;

            newcoloring = name;
            newcoloring -= graph->precompexp[positionctr][curcol];
            newcoloring += graph->precompexp[positionctr][colorctr];

            it = graph->vertices.find(newcoloring); // valid coloring?
            if (it == graph->vertices.end())
                continue;

            colorctr++;
            return newcoloring;
        }

        colorctr = 0;
    }

    // positionctr = 0;
    // colorctr = 0;
    throw std::out_of_range("");
}


bool
ColoringVertexNeighborIterator::
hasnext()
{
    int p = positionctr, c = colorctr;
    // long rem = remaining;
    if (positionctr >= graph->base->size())
        return false;

    try
    {
        next();
        positionctr = p;
        colorctr = c;
        // remaining = rem;
        return true;// and remaining;
    }
    catch (std::out_of_range& e)
    {
        return false;
    }
}


/*******************************************************************************
*************************** MetaVertexNeighborIterator *************************
*******************************************************************************/


MetaVertexNeighborIterator::
MetaVertexNeighborIterator(std::unordered_set<long>::iterator it_, long len_)
    : it(it_), len(len_)
{}


long
MetaVertexNeighborIterator::
next()
{
    if (this->len--)
        return *this->it++;

    throw std::out_of_range("");
}


bool
MetaVertexNeighborIterator::
hasnext()
{
    return (this->len > 0);
}


/*******************************************************************************
*********************************** MetaVertex *********************************
*******************************************************************************/


MetaVertex::
MetaVertex(long name_)
    : Vertex(name_), nt(new MetaVertexNeighborIterator()), identity(-1)
{}


MetaVertex::
~MetaVertex()
{}


int
MetaVertex::
size()
{
    return vertices.size();
}


void
MetaVertex::
add_neighbor(MetaVertex& other)
{
    neighbors.insert(other.name);
    delete nt;
    nt = new MetaVertexNeighborIterator(neighbors.begin(),
                                        (long)neighbors.size());
}


// template <typename V>
void
MetaVertex::
connect(MetaVertex* v)
{
    add_neighbor(*v);
    v->add_neighbor(*this);
}


// template <typename V>
void
MetaVertex::
disconnect(MetaVertex* v)
{
    if (this->neighbors.find(v->name) != this->neighbors.end())
	    this->neighbors.erase(v->name);
    if (v->neighbors.find(this->name) != v->neighbors.end())
    	v->neighbors.erase(this->name);
}


long
MetaVertex::
get_next_neighbor()
{
    return nt->next();
}


bool
MetaVertex::
has_next_neighbor()
{
    return nt->hasnext();
}


void
MetaVertex::
reset_neighbor_track()
{
    delete nt;
    nt = new MetaVertexNeighborIterator(neighbors.begin(),
                                        (long)neighbors.size());
}


MetaVertexNeighborIterator*
MetaVertex::
__iter__()
{
    return new MetaVertexNeighborIterator(neighbors.begin(),
                                          (long)neighbors.size());
}

MetaVertexNeighborIterator*
MetaVertex::
get_neighbors()
{
    return __iter__();
}


MetaVertexStoredVerticesIterator*
MetaVertex::
get_vertices()
{
    return new MetaVertexStoredVerticesIterator(vertices.begin(), size());
}


#endif
