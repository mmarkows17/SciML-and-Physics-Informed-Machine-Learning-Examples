function x = meshgraphnet(p,x,xe,B,cfg)
    % A mesh graph network. 
    
    % Add Fourier position embeddings.
    x = meshgraphnet.fourierPositionalEmbedding(x,cfg.MaxFreq);
    
    % Encode node and edge features with MLPs.
    x = meshgraphnet.mlp(p.node_encoder,x,cfg.NumLayersEncoder);
    xe = meshgraphnet.mlp(p.edge_encoder,xe,cfg.NumLayersEncoder);
    
    % Loop over "processors" - message passing layers between edges and nodes.
    z = x;
    for i = 1:cfg.NumProcessors
    
        % Accumulate node features onto edges
        xe = meshgraphnet.node_to_edge_accumulation(x,xe,B);
    
        % Apply MLP to edge representations
        xe = meshgraphnet.mlp(p.processors.("edge_processor_"+i),xe,cfg.NumLayersProcessor);
    
        % Accumulate edge features onto nodes.
        x = meshgraphnet.edge_to_node_accumulation(x,xe,B);
    
        % Apply MLP to node representations.
        x = meshgraphnet.mlp(p.processors.("node_processor_"+i),x,cfg.NumLayersProcessor);
    end
    
    % Residual connection around the processors.
    x = x+z;
    
    % Node decoder.
    x = meshgraphnet.mlp(p.node_decoder,x,cfg.NumLayersDecoder);
end