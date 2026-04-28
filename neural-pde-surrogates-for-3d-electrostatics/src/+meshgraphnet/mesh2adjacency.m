function A = mesh2adjacency(mesh)
    % This function assumes mesh is an FEMesh for 3d data and of quadratic
    % order.
    
    numNodes = size(mesh.Nodes,2);
    
    % https://uk.mathworks.com/help/pde/ug/mesh-data.html
    % Specify the edges from the above webpage.
    r = [1,5,2,6,3,10,4,8,1,7,2,9];
    c = [5,2,6,3,10,4,8,1,7,3,9,4];
    
    % Get the node indices of those edges from the elements.
    R = mesh.Elements(r,:);
    C = mesh.Elements(c,:);
    
    % Construct a sparse adjacency matrix.
    V = ones(size(R));
    R = reshape(R,[],1);
    C = reshape(C,[],1);
    V = reshape(V,[],1);
    A = sparse(R,C,V,numNodes,numNodes);
    
    % Add self loops - we'll typically use those in a GNN as a node can feed
    % features back to itself. In principle you could also just add residual
    % connections around any graph convolution or node-node message pass. 
    A = A + speye(numNodes);
    
    % Symmetrise the adjacency (we didn't include the other direction of edges
    % in the r,c above) and make sure all the entries are 0 or 1 (in case we
    % double counted anywhere).
    A = double((A>0) | (A'>0));
end