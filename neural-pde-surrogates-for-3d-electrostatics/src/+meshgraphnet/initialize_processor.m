function p = initialize_processor(cfg)
    % Initialization function for the message passing processor layers.
    %
    % cfg is a struct of configuration data.
    p = struct();
    for i = 1:cfg.NumProcessors
        p.("node_processor_"+i) = meshgraphnet.initialize_mlp(cfg.HiddenSize,cfg.HiddenSize,cfg.NumLayersProcessor);
        p.("edge_processor_"+i) = meshgraphnet.initialize_mlp(cfg.HiddenSize,cfg.HiddenSize,cfg.NumLayersProcessor);
    end
    p = dlupdate(@dlarray,p);
end