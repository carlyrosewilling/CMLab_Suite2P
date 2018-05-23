function [frames, headers] = loadFrames(tiff, firstIdx, lastIdx, stride, temp_file)
%loadFrames Loads the frames of a Tiff file into an array (Y,X,T)
%   MOVIE = loadFrames(TIFF, [FIRST], [LAST], [STRIDE], []) loads
%   frames from the Tiff file specified by TIFF, which should be a filename
%   or an already open Tiff object. Optionallly FIRST, LAST and STRIDE
%   specify the range of frame indices to load.

if nargin>4
   copyfile(tiff,temp_file) 
   tiff = temp_file;
end

% initChars = overfprintf(0, 'Loading TIFF frame ');
warning('off', 'MATLAB:imagesci:tiffmexutils:libtiffWarning');

warningsBackOn = onCleanup(...
  @() warning('on', 'MATLAB:imagesci:tiffmexutils:libtiffWarning'));

if ischar(tiff)
  [tiff tifinfo] = read_patterned_tifdata(tiff);
end

if nargin < 2
  firstIdx = 1;
end

if nargin < 3
  lastIdx = tifinfo.nframes; 
end

if nargin < 4
  stride = 1;
end



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

