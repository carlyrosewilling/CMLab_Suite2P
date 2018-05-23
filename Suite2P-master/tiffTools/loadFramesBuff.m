function [frames, headers] = loadFramesBuff(tiff, firstIdx, lastIdx, stride, temp_file)
%loadFrames Loads the frames of a Tiff file into an array (Y,X,T)
%   MOVIE = loadFrames(TIFF, [FIRST], [LAST], [STRIDE], []) loads
%   frames from the Tiff file specified by TIFF, which should be a filename
%   or an already open Tiff object. Optionallly FIRST, LAST and STRIDE
%   specify the range of frame indices to load.
firstIdx = firstIdx + 2; %Removes the first 2 frames from each video due to problems with recording.
if nargin>4 && ~isempty(temp_file)
    if ~isequal(tiff, temp_file) % do not copy if already copied
        % in case copying fails (server hangs)
        iscopied = 0;
        firstfail = 1;
        while ~iscopied
            try       
                copyfile(tiff,temp_file);
                iscopied = 1;
                if ~firstfail
                    fprintf('  succeeded!\n');
                end
            catch
                if firstfail
                    fprintf('copy tiff failed, retrying...');
                end
                firstfail = 0;
                pause(10);
            end
        end
        tiff = temp_file;
    end
    [~, info] = read_patterned_tifdata(temp_file);
    if isnan(lastIdx)
        lastIdx = info.nframes; 
    end
end

% initChars = overfprintf(0, 'Loading TIFF frame ');
warning('off', 'MATLAB:imagesci:tiffmexutils:libtiffWarning');

warningsBackOn = onCleanup(...
    @() warning('on', 'MATLAB:imagesci:tiffmexutils:libtiffWarning'));

if ischar(tiff)
    [tiff tifinfo] = read_patterned_tifdata(tiff);
end

if nargin < 2 || isempty(firstIdx)
    firstIdx = 3;
end

if nargin < 3 || isempty(lastIdx)
    lastIdx = tifinfo.nframes;
end

if nargin < 4 || isempty(stride)
    stride = 1;
end


if true %nargin <=4  
    w = tifinfo.tifinfo.ImageWidth;
    h = tifinfo.tifinfo.ImageLength; 
    dataClass = 'int16';
    nFrames = ceil((lastIdx - firstIdx + 1)/stride);
    frameIndex = firstIdx:stride:lastIdx;
    frames = zeros(h, w, nFrames, dataClass);
    
    for t = 1:nFrames
        frames(:,:,t) = tiff(:,:,frameIndex(t));
    end 
 
else % if the file is local (and on SSD) this way of reading works much faster

    w = tifinfo.tifinfo.ImageWidth;
    h = tifinfo.tifinfo.ImageLength; 
    dataClass = 'int16';
    nFrames = ceil((lastIdx - firstIdx + 1)/stride);
    frameIndex = firstIdx:stride:lastIdx;
    frames = zeros(h, w, nFrames, dataClass);
    
    for t = 1:nFrames
        frames(:,:,t) = tiff(:,:,frameIndex(t));
    end 
    
end


end


%%
%
% figure
% for i=1:3:nFrames
%     subplot(1, 3, 1)
%     imagesc(frames(:,:,i));
%     subplot(1, 3, 2);
%     imagesc(data(:,:,i));
%     subplot(1, 3, 3);
%     imagesc(frames(:,:,i)-data(:,:,i));
%     drawnow;
% end

