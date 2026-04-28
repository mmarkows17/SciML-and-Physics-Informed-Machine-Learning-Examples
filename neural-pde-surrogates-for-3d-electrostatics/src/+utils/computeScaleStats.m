function [offset,scale] = computeScaleStats(data, rangeSpec, varargin)
%computeScaleStats Compute row-wise scaling statistics for [0,1] or [-1,1].
%   [offset, scale] = computeScaleStats(data, rangeSpec) computes per-row
%   offset and scale so that scaled = (data - offset) ./ scale maps each
%   row to the specified range.
%
%   Inputs:
%       data      - 1xK cell array (each DxNi) or matrix (DxN)
%       rangeSpec - Target range: '[0,1]' or '[-1,1]'
%
%   Name-Value Arguments:
%       CoordIdx    - Indices of coordinate rows (e.g., 1:3). Default: []
%       CoordPolicy - 'none' (default) or 'zero-center-uniform'
%
%   Outputs:
%       offset - Dx1 offset vector
%       scale  - Dx1 scale vector
%
%   Note: 'zero-center-uniform' sets offset to 0 and uses a uniform scale
%   factor across coordinate rows to preserve aspect ratio.

p = inputParser;
addParameter(p, 'CoordIdx', [], @(x) isnumeric(x));
addParameter(p, 'CoordPolicy', 'none', @(s) ismember(s, {'none','zero-center-uniform'}));
parse(p, varargin{:});

coordIdx   = p.Results.CoordIdx;
coordPol   = p.Results.CoordPolicy;

% Concatenate training samples along columns
if iscell(data)
    allMat = cat(2, data{:});  % [D x sum(Ni)]
else
    allMat = data;              % [D x N]
end

% Concatenate training samples along columns
rowMin = min(allMat, [], 2);
rowMax = max(allMat, [], 2);

switch rangeSpec
case '[0,1]'
    offset = rowMin;
    scale  = rowMax - rowMin;
case '[-1,1]'
    offset = 0.5 * (rowMin + rowMax);          % midrange
    scale  = 0.5 * (rowMax - rowMin); % half-range
otherwise
    error('rangeSpec must be "[0,1]" or "[-1,1]".');
end

% Optional coordinate policy
if ~isempty(coordIdx) && strcmp(coordPol, 'zero-center-uniform')
    offset(coordIdx) = 0;                        % zero-center coordinates
    s = max(scale(coordIdx));                    % uniform scaling across x,y,z
    scale(coordIdx) = s;
end

end
