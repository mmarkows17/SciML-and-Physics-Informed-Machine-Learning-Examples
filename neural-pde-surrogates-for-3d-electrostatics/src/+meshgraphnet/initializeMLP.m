function p = initializeMLP(inputSize,hiddenSize,numLayers)
    % initializeMLP Initialize learnable parameters for an MLP.
    %
    %   p = meshgraphnet.initializeMLP(inputSize, hiddenSize, numLayers)
    %   creates a struct of weight matrices and bias vectors for an MLP with
    %   the specified number of layers. Layer sizes are
    %   [inputSize, hiddenSize, ..., hiddenSize]. Weights are initialized
    %   using Glorot uniform initialization and biases are initialized to
    %   zero.
    %
    %   Inputs:
    %       inputSize  - Size of the input features.
    %       hiddenSize - Size of each hidden layer (and output layer).
    %       numLayers  - Number of layers in the MLP.
    %
    %   Output:
    %       p - Struct with fields fc_1, fc_2, ..., fc_numLayers, each
    %           containing W (weight matrix) and b (bias vector).

    %   Copyright 2026 The MathWorks, Inc.
    p = struct();
    sz = [inputSize, repelem(hiddenSize,numLayers)];
    for i = 1:numLayers
        p.("fc_"+i).W = meshgraphnet.initializeGlorot(sz(i),sz(i+1));
        p.("fc_"+i).b = zeros(sz(i+1),1);
    end
end
