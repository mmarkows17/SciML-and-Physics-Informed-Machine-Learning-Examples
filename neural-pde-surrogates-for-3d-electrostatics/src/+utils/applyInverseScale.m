function out = applyInverseScale(data,offset,scale)

rowMap = @(X) X.*scale + offset; 

if iscell(data)
    out = cellfun(@(X) rowMap(X), data, 'UniformOutput', false);
else
    out = rowMap(data);
end
    
end