function convert_to_readabletif(ops0, db, greenonly)
%DOESNT WORK YET
%converts raw ScanImage tiff to smaller tiff readable by ImageJ
ops = build_ops3(db, ops0);
ReadableDir = fullfile(ops.RootDir, int2str(ops.nplanes), 'Readable');
mkdir(ReadableDir);
for f = 1:length(ops.fsroot{1})
    tiff = ops.fsroot{1}(f).name;
    [imgdata, imginfo] = read_patterned_tifdata(tiff);

    w = imginfo.tifinfo.ImageWidth;
    h = imginfo.tifinfo.ImageLength; 
    dataClass = 'int16';
    lastIdx = imginfo.nframes;
    if greenonly == 1 
        firstIdx = 1;
        nFrames = ceil((lastIdx-firstIdx + 1)/2);
        frameIndex = firstIdx:2:lastIdx;
        frames = zeros(h, w, nFrames,dataClass);
    
        for r = 1:nFrames
            frames(:,:,r) = imgdata(:,:,frameIndex(r));
        end 
        fname = strrep(tiff, '.tif', '_greenreadable.tif');
    else
        frames = imgdata;
        fname = strrep(tiff, '.tif', '_readable.tif');
    end 
    fid = fopen(tiff, 'r');
    TiffWriter(frames, fname, 16);
end 

end 
    
