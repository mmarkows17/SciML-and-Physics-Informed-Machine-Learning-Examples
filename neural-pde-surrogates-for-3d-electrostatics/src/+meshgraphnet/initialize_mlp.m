function p = initialize_mlp(inputSize,hiddenSize,numLayers)
    % Initializer for the weights used in mlp.
    p = struct();
    sz = [inputSize, repelem(hiddenSize,numLayers)];
    for i = 1:numLayers
        p.("fc_"+i).W = meshgraphnet.glorot(sz(i),sz(i+1));
        p.("fc_"+i).b = zeros(sz(i+1),1);
    end
    p = dlupdate(@dlarray,p);
end
