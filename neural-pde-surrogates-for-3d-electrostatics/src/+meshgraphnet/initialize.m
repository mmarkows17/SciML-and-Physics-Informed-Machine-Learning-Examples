function p = initialize(cfg)
    % Initialization function for the mgn.
    %
    % cfg is a struct of configuration data.
    p.node_encoder = meshgraphnet.initialize_mlp(cfg.NodeInputSize*(2*cfg.MaxFreq+1),cfg.HiddenSize,cfg.NumLayersEncoder);
    p.edge_encoder = meshgraphnet.initialize_mlp(cfg.EdgeInputSize,cfg.HiddenSize,cfg.NumLayersEncoder);
    p.processors = meshgraphnet.initialize_processor(cfg);
    p.node_decoder = meshgraphnet.initialize_mlp(cfg.HiddenSize,cfg.OutputSize,cfg.NumLayersDecoder);
end