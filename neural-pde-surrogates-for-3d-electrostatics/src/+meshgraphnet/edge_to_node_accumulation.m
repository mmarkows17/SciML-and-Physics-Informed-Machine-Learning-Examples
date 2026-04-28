function x = edge_to_node_accumulation(x,xe,B)
    % B is the node-edge adjacency, x the node features and xe the edge
    % features. x is H x NumNodes and xe is H x NumEdges. 
    % Requires hidden size to be same for nodes and edges so that we can add x
    % and xe.
    % xe * B' accumulates edge features onto nodes.
    xe = xe*B';
    x = x+xe;
end 