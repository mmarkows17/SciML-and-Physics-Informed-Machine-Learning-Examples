function [inputs,targets,efieldTargets] = preprocessData(data,stride)
    inputs = cell(numel(data),1);
    targets = cell(numel(data),1);
    efieldTargets = cell(numel(data),1);

        function [input,target,efield] = extractInputAndTarget(data,stride)

            input = cat(1, ...
                data.Coord,...
                data.Epsilon');

            % target is the potential
            target = data.Potential';

            % electric field target (3 x N)
            efield = data.ElectricField;

            % Find any nodes with a NaN input, target, or E-field. Remove them.
            nanInput = isnan(input);
            nanTarget = isnan(target);
            nanEfield = isnan(efield);
            nanNode = any(nanInput,1) | any(nanTarget,1) | any(nanEfield,1);
            input(:,nanNode) = [];
            target(:,nanNode) = [];
            efield(:,nanNode) = [];
            input = input(:,1:stride:end);
            target = target(:,1:stride:end);
            efield = efield(:,1:stride:end);
        end

    % Loop over data
    for i = 1:numel(data)
        [inputs{i},targets{i},efieldTargets{i}] = extractInputAndTarget(data(i),stride);
    end
end