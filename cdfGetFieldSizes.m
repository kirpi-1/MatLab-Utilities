function fsize = cdfGetFieldSizes(dataStruct)
    fnames=fieldnames(dataStruct);
    fsize = zeros(length(fnames),1);
    for a=1:length(fnames)        
        item = dataStruct.(fnames{a});
        numItems = max(size(item,1));        
        if ischar(item) || isa(item,'uint8') || isa(item,'int8') || isa(item,'logical')
            baseSize = 1;            
        elseif isa(item,'uint16') || isa(item,'int16')
            baseSize = 2;
        elseif isa(item,'uint32') || isa(item,'int32') || isa(item,'single')
            baseSize = 4;
        elseif isa(vertcat(item),'double')
            baseSize = 8;
        end
        fsize(a) = baseSize*numItems;
    end
end