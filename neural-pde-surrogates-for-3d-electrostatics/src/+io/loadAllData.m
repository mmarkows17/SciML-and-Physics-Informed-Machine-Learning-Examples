function data = loadAllData(dataRootDir)
    metadata = dir(fullfile(dataRootDir,"*.mat"));
    fname = fullfile(dataRootDir,{metadata.name});
    
        function data = loadData(fname)
            data = load(fname);
            data = data.D;
        end
    
    data = arrayfun(@loadData, fname, UniformOutput = true);
end