function data = suite2p_convert(stat,ops,Fcell)
%This function converts data structure output from Suite2P into data
%structure needed to run through analysis code adapted from ATPIA (readme)



L = length(stat);   %Check how many ROIs exist
% Check to make sure there are actually ROIs. If not, return to parent fxn
if L == 0
    error('This file contains no ROIs')
end
data.zproj = ops.mimg;  %Add zproj image to data structure
data.fluo = Fcell';  %Add fluroscence data to structure
%Load ROI pixel (location) data to x; Can be written more efficiently
x{L} = [];  %Initialize x for storing ROI pixels
for i = 1:L
    x{i} = stat(i).ipix;
end
data.ROIs = x; %Store pixel information into structure
clear x %Clear temporary variable
data.overlay = zeros(size(ops.mimg,1),size(ops.mimg,2)); %Initialize ROI mask
data.overlay(vertcat(data.ROIs{:})) = 1;    %Populate mask with 1 wherever ROIs exist
data.stats = CaStats(data.fluo);    %Run Statistical Analysis on the data

end