function out = convertGpuToCpu(in)
    if isa(in, 'dlarray') || isa(in, 'gpuArray')
        out = gather(in);
    elseif isstruct(in)
        % Apply recursively to each field
        out = struct();
        fields = fieldnames(in);
        for i = 1:numel(fields)
            out.(fields{i}) = utils.convertGpuToCpu(in.(fields{i}));
        end
    elseif iscell(in)
        % Apply recursively to each cell element
        out = cellfun(@utils.convertGpuToCpu, in, 'UniformOutput', false);
    else
        % Leave other data types unchanged
        out = in;
    end
end