function x = mlp(params,x,numLayers)
    % A simple multi-layer perceptron.
    for i = 1:(numLayers-1)
        p = params.("fc_"+i);
        z = pagemtimes(p.W,x) + p.b;
        z = gelu(z);
        if i > 1
            % Add a residual connection. This is possible when x and z have the
            % same size, which is always the case after the first layer in the
            % below setup. 
            x = x + z;
        else
            x = z;
        end
    end
    p = params.("fc_"+numLayers);
    z = pagemtimes(p.W,x) + p.b;
    x = x+z;
end