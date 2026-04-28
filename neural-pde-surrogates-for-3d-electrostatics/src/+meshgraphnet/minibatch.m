function [X,Xe,B,Y] = minibatch(X,Xe,B,Y,useGpu)
    % Batch together a cell of node features, edge features, node-edge
    % adjacencies, and node targets.
    %
    % The main interesting thing is that you compute the blkdiag of adjacencies
    % to batch them and stack together the node/edge and batch dimensions for the 
    % other data.
    
    if useGpu
        X = gpuArray(dlarray(cat(2,X{:})));
    else
        X = dlarray(cat(2,X{:}));
    end
    B = blkdiag(B{:});

    
    % Normalize by num edges connected to a node. This helps prevent the model
    % "blowing up" initially (suppose B==1 for all edges connected to a node,
    % then for a node with many edges connected to it, the edge-to-node
    % accumulation will sum up a bunch of randomly initialized vectors, and
    % this tends to output very large values -- or else very large variance. So
    % normalizing by the number of edges connected to a node helps mitigate
    % this. This is standard, though different normalizations are used by
    % different GNN methods, e.g. see the GCN examples which take a slightly
    % different approach).
    B = B ./ sum(B,2);
    if useGpu
        Xe = gpuArray(dlarray(cat(2,Xe{:})));
        Y = gpuArray(dlarray(cat(2,Y{:})));
        B = gpuArray(B);
    else
        Xe = dlarray(cat(2,Xe{:}));
        Y = dlarray(cat(2,Y{:}));
    end
end