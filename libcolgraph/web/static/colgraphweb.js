/* colgraphweb.js */

options = {
	"manipulation": {"enabled": false},
    "configure": {"enabled": false},
    "edges": {
        "color": {"inherit": true},
        "smooth": {
            "enabled": false,
            "type": "continuous"
         }
    },
    "nodes": {
        "shape": "dot"
    },
    "interaction": {
        "hover": true,
        "dragNodes": true,
        "hideEdgesOnDrag": false,
        "hideNodesOnDrag": false
    },
    "physics": {
        "barnesHut": {
            "avoidOverlap": 0,
            "centralGravity": 0.5,
            "damping": 0.09,
            "gravitationalConstant": -80000,
            "springConstant": 0.001,
            "springLength": 250
        },
        "enabled": true,
        "adaptiveTimestep": true,
        "stabilization": {
            "enabled": false,//true,
            "fit": true,
            "iterations": 100,
            "onlyDynamicEdges": false,
            "updateInterval": 10
        }
    }
};


// same options for now
bgoptions = mcgoptions = cgoptions = pcgoptions = options;

function color_on_click (requesturl) {
    // creates a function based on passed param 'requesturl' and returns it
    function _color_on_click (params) {
        if (params.nodes.length > 0) {
            var value = JSON.stringify([params.nodes, 'node'], undefined, 2);
            $.ajax({
                type: "POST",
                url: requesturl,
                data: value,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var bgcontainer = $('#bgcontainer');
                    bgcontainer.html(response['bgcontainer']);
                    makebg();
                    if ('stats' in response) {
                        stats = response['stats'];
                        $('#topstatsdisplay').text(stats);
                    }
                },
                error: function (response) {
                    alert('ERROR', response);
                }
            });
        }
        else if (params.edges.length == 1) {
            var value = JSON.stringify([params.edges, 'edge'], undefined, 2);
            $.ajax({
                type: "POST",
                url: requesturl,
                data: value,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var bgcontainer = $('#bgcontainer');
                    bgcontainer.html(response['bgcontainer']);
                    makebg();
                },
                error: function (response) {
                    alert('ERROR', response);
                }
            });
        }
    }
    return _color_on_click;
}


function makebg() {
    bgcontainer = document.getElementById('bgcontainer');
    bgdata = {
        nodes: bgnodes,
        edges: bgedges
    };
    // create a basegraph
    basegraph = new vis.Network(bgcontainer, bgdata, bgoptions);
    basegraph.setOptions({"manipulation": {"enabled": true}});
    basegraph.setOptions({"physics": {"stabilization": {"enabled": true}}});
    basegraph.on("stabilizationIterationsDone", function (params) {
        basegraph.fit();
    });
    basegraph.stabilize();
    return basegraph;
}

function makecg() {
    cgcontainer = document.getElementById('cgcontainer');
    cgdata = {
        nodes: cgnodes,
        edges: cgedges
    };
    // create a coloringgraph
    coloringgraph = new vis.Network(cgcontainer, cgdata, cgoptions);
    coloringgraph.setOptions({"interaction": {"hideEdgesOnDrag": true}});
    coloringgraph.fit();

    coloringgraph.on("click", color_on_click("/colorbg_from_cg"));

    return coloringgraph;
}

function makemcg() {
    mcgcontainer = document.getElementById('mcgcontainer');
    mcgdata = {
        nodes: mcgnodes,
        edges: mcgedges
    };
    // create a metagraph
    metacoloringgraph = new vis.Network(mcgcontainer, mcgdata, mcgoptions);
    metacoloringgraph.setOptions({"physics": {"stabilization": {"enabled": true}}});
    metacoloringgraph.on("stabilizationIterationsDone", function (params) {
        metacoloringgraph.fit();
    });
    metacoloringgraph.stabilize();

    // listener to color the BaseGraph
    metacoloringgraph.on("click", color_on_click("/colorbg_from_mcg"));

    return metacoloringgraph;
}

function makepcg() {
    pcgcontainer = document.getElementById('pcgcontainer');
    pcgdata = {
        nodes: pcgnodes,
        edges: pcgedges
    };
    // create a metagraph
    partialcoloringgraph = new vis.Network(pcgcontainer, pcgdata, pcgoptions);
    partialcoloringgraph.setOptions({"physics": {"stabilization": {"enabled": true}}});
    partialcoloringgraph.on("stabilizationIterationsDone", function (params) {
        partialcoloringgraph.fit();
    });
    partialcoloringgraph.stabilize();

    partialcoloringgraph.on("click", color_on_click("/colorbg_from_cg"));

    return partialcoloringgraph;
}

basegraph = makebg();
coloringgraph = makecg();
metacoloringgraph = makemcg();
partialcoloringgraph = makepcg();

function objectToArray(obj) {
    return Object.keys(obj).map(function (key) {
      obj[key].id = key;
      return obj[key];
    });
}

function exportNetwork(network) {

    // function addConnections(elem, index) {
    //     elem.connections = network.getConnectedNodes(index);
    // }

    var nodes = objectToArray(network.getPositions());
    for (var ix = 0; ix < nodes.length; ix++) {
        nodes[ix]["connections"] = network.getConnectedNodes(nodes[ix]["id"]);
    }
    postdata = [
        nodes,
        document.getElementById('numcolors-textfield').value
    ]
    var exportValue = JSON.stringify(postdata, undefined, 2);

    return exportValue;
}

function generate(e) {
    // e.preventDefault();
    var value = exportNetwork(basegraph);
    $.ajax({
        type: "POST",
        url: "/generate",
        data: value,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            // alert('RESPONSE OK');
            var bgcontainer = $('#bgcontainer');
            bgcontainer.html(response['bgcontainer']);
            makebg();
            var cgcontainer = $('#cgcontainer');
            cgcontainer.html(response['cgcontainer']);
            if (Number(response['cgsize']) <= 512) {
                $('#force-cg-button').hide();
                makecg();
                coloringgraph.stabilize();
                coloringgraph.fit();
            } else {
                alert('coloringgraph not loaded due to size. you can choose to display it anyway.');
                $('#force-cg-button').show();
            }
            var mcgcontainer = $('#mcgcontainer');
            mcgcontainer.html(response['mcgcontainer']);
            makemcg();
            var pcgcontainer = $('#pcgcontainer');
            pcgcontainer.html(response['pcgcontainer']);
            makepcg();
            get_stats();
        },
        error: function (response) {
            alert('ERROR', response);
        }
    });
    // location.reload();
}



function get_cg_data(e) {
    var value = exportNetwork(basegraph);
    $.ajax({
        type: "POST",
        url: "/cgdata",
        data: value,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            // alert('RESPONSE OK');
            var cgcontainer = $('#cgcontainer');
            cgcontainer.html(response['cgcontainer']);
            makecg();
            get_stats();
        },
        error: function (response) {
            alert('ERROR', response);
        }
    });
}



function get_stats(e) {
    var value = exportNetwork(basegraph);
    $.ajax({
        type: "POST",
        url: "/cgstats",
        data: value,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            // alert('RESPONSE OK');
            cgstats = response['stats'];
            $('#topstatsdisplay').text(cgstats);
        },
        error: function (response) {
            alert('ERROR', response);
        }
    });
}


function save(e) {
    var value = exportNetwork(basegraph);
    $.ajax({
        type: "POST",
        url: "/save",
        data: value,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            alert('saved OK');
        },
        error: function (response) {
            alert('ERROR', response);
        }
    });
}


function load_file(e) {
    var value = exportNetwork(basegraph);
    $.ajax({
        type: "POST",
        url: "/load",
        data: value,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            var bgcontainer = $('#bgcontainer');
            bgcontainer.html(response['bgcontainer']);
            makebg();
        },
        error: function (response) {
            alert('ERROR', response);
        }
    });
}


function randomgraph(e) {
    var value = exportNetwork(basegraph);
    $.ajax({
        type: "POST",
        url: "/generate_random",
        data: value,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            var bgcontainer = $('#bgcontainer');
            bgcontainer.html(response['bgcontainer']);
            makebg();
        },
        error: function (response) {
            alert('ERROR', response);
        }
    });
}



function refresh_page(e) {
    location.reload();
    // $(document).ready( function() {
    //     generate();
    //     get_stats();
    // });
    // generate();
    // get_stats();
}
