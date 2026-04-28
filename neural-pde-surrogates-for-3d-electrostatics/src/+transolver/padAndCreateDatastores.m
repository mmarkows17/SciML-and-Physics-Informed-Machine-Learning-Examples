function [cds,cdsVal] = padAndCreateDatastores(...
    normalizedInputsTrain,normalizedInputsVal,...
    normalizedTargetsTrain,normalizedTargetsVal)
    [paddedInputsTrain,maskTrain] = padsequences(normalizedInputsTrain,2);
    [paddedInputsVal,maskVal] = padsequences(normalizedInputsVal,2);
    paddedTargetsTrain = padsequences(normalizedTargetsTrain,2);
    paddedTargetsVal = padsequences(normalizedTargetsVal,2);
    
    inputDsTrain = transolver.datastore.RandomAugmentationDatastore(paddedInputsTrain);
    maskDsTrain = arrayDatastore(maskTrain(1,:,:),IterationDimension=3);
    targetDsTrain = arrayDatastore(paddedTargetsTrain,IterationDimension = 3);
    inputDsVal = arrayDatastore(paddedInputsVal,IterationDimension=3);
    maskDsVal = arrayDatastore(maskVal(1,:,:),IterationDimension=3);
    targetDsVal = arrayDatastore(paddedTargetsVal,IterationDimension=3);
    
    cds = combine(inputDsTrain,maskDsTrain,targetDsTrain,maskDsTrain);
    cdsVal = combine(inputDsVal,maskDsVal,targetDsVal,maskDsVal);
end