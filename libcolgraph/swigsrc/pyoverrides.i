/* pyoverrides.i */


%extend Vertex {
    %pythoncode %{
        def __str__(self):
            '''
            Returns
            ---
            str
            	a short string representation of Vertex instance
            '''
            return '<Vertex [{}, size:{}] of {} >'.format(self.get_name(),
                                                          self.size(), 
                                                          type(self))

        def __repr__(self):
            return self.__str__()

        def __len__(self):
            '''
            Returns
            -------
            int
                output of size() of vertex, represents number of vertices in a
                metavertex, or 1 in case of a BaseVertex, or ColoringVertex 
                instance
            '''
            return self.size()
    %}
};

%extend Graph {
    %pythoncode %{
        def __str__(self):
            '''
            Returns
            -------
            str
            	a short string representation of Graph instance
            '''
            return '<Graph (size={}) of {} >'.format(len(self), type(self))

        def __repr__(self):
            return self.__str__()

        def __len__(self):
            '''
            Returns
            -------
            int
            	output of size() of graph, represents number of vertices
            '''
            return self.size()

        def pretty_print(self):
            '''
            Returns
            -------
            str
            	a nicely formatted complete representation of Graph instance
            '''
            
            print('INFO: pretty_printing', self, 'vertices followed by their '
                                                 'neighbors')
            for v in sorted(self.get_vertices(), key=lambda v: v.get_name()):
                print('\t', v.get_name(), ':  ',
                      *[n for n in sorted(v.get_neighbors())])
    %}
};
%extend BaseGraph {
    %pythoncode %{
        def load_from_nx(self, g=None):
            '''
            method that accepts an instance of a networkx graph
            and loads that graph into this instance of BaseGraph
            
            Parameters
            ----------
            g: networkx graph object
                an instantiated networkx graph to load from
            
            '''
            import networkx as nx
           
            self.reset() # first clear existing graph
             
            lookup = dict()
            for i, (v, adjdict) in enumerate(g.adjacency()):
                lookup[v] = i
                self.add_vertex(i)
            for i, (v, adjdict) in enumerate(g.adjacency()):
                for otherv in adjdict:
                    self.make_edge(lookup[v], lookup[otherv])


        def generate_random(self, v:int, p:float):
            '''
            method that creates a random graph at the current BaseGraph
            instance using the Erdos-Reyni random graph model
            
            Parameters
            ----------
            v : int
            	how many vertices the graph should have
            p : float[0,1]
                what probability to use while generating edges between pairs 
                of vertices
            '''
            import networkx as nx

            assert 0. <= p <= 1., ValueError('invalid probabilities')
            assert 0 <= v, ValueError('bad number of vertices')

            g = nx.erdos_renyi_graph(v, p)
            self.load_from_nx(g) 
    %}
}
