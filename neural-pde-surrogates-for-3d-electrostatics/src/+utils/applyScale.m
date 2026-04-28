function out = applyScale(data,offset,scale)

rowMap = @(X) (X-offset)./scale;

if iscell(data)
    out = cellfun(@(X) rowMap(X), data, 'UniformOutput', false);
else
    out = rowMap(data);
end
    
end