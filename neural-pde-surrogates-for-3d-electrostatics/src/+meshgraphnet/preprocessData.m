function [X,Xe,Y,A,B] = preprocessData(data,keep)
    
    % Set coordinates as node features.
    % Note: the mesh graph network paper suggests to not use coordinates as
    % node features, as many physics problems will be translation invariant,
    % and coordinate node features would cause overfitting. Instead they
    % propose to include only relative positional information such as the
    % displacement vectors between nodes as edge features (added below).
    % However we have no other node features (epsilon is constant and equal to
    % 5 on the transformer bushing), so I include the coordinate features so we
    % have some node feature. 
    % We could add a node feature that is 1 if the node is on the boundary of
    % the transformer bushing. I've been interested in adding geometric
    % features too, such as curvatures of the 2d surface of the object at the
    % node.
    
    % Only consider the nodes designated by "keep"
    if isempty(keep)
        keep = 1:size(data.Mesh.Nodes,2);
    end
    X = data.Mesh.Nodes(:,keep);
    if isfield(data,'Potential')
        Y = data.Potential(keep)';
    else
        Y = []; % don't return targets
    end
    
    % Get the adjacency matrix.
    A = meshgraphnet.mesh2adjacency(data.Mesh);
    
    % Only retain the nodes we designated to keep.
    A = A(keep,:);
    A = A(:,keep);
    
    % Now construct the "node-edge adjacency", a matrix B of size 
    % NumNodes x NumEdges
    % where B(i,j) = 1 if node i is one of the two nodes attached to edge j.
    %
    % This will be used in mesh graph net type networks that accumulate edge
    % features onto nodes and node features onto edges.
    %
    % We recompute R,C here to include the self loops and the edges from 
    % symmetrisation above.
    [r,c] = find(A);
    rc = [r;c];
    
    % Number the edges 1 -> numEdges following R and C
    edgeLabels = [(1:numel(r))';(1:numel(r))'];
    
    % Construct the sparse node-edge adjacency.
    B = sparse(rc,edgeLabels,ones(size(rc)),size(A,1),numel(r));
    B = double(B>0);
    
    % Construct edge features. Here I just use displacements and lengths.
    % Angles could also be included.
    % When dealing with multiple materials, you could
    % include a feature for crossing a boundary.
    Xe = X(:,r) - X(:,c);
    Xe = [Xe; sqrt(sum(Xe(1:3,:).^2,1))];
end