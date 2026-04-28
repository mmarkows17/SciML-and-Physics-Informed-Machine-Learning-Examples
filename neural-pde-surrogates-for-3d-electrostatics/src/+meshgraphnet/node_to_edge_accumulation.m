function xe = node_to_edge_accumulation(x,xe,B)
    % B is the node-edge adjacency, x the node features and xe the edge
    % features. x is H x NumNodes and xe is H x NumEdges. 
    % Requires hidden size to be same for nodes and edges so that we can add x
    % and xe.
    % x*B accumulates node features onto the edges (i.e. if edge i is defined
    % by nodes j and k, then 
    % (x*B)(:,i) == x(:,j) + x(:,k)
    %  more or less (B may be normalized, e.g. by the number of edges connected
    %  to a node, so in practice there are coefficients in front of the terms
    %  on the RHS).
    x = x*B;
    xe = x + xe;
end