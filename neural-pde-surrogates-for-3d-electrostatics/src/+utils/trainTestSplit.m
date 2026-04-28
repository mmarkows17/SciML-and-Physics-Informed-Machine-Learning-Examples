function [trainIdx,valIdx] = trainTestSplit(numObs,trainRatio)
    idx = randperm(numObs);
    numTrain = floor(trainRatio*numObs);
    trainIdx = idx(1:numTrain);
    valIdx = idx(numTrain+1:end);
end