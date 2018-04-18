function data = singleAnalysis()
warning ('off','all');

[fileN,pathN] = uigetfile('.mat','Select .mat file from Suite2P');
fullFileN = fullfile(pathN,fileN);
load(fullFileN)

L = length(stat);
data.zproj = ops.mimg;
data.fluo = Fcell{1}';
x{L} = [];
for i = 1:L
    x{i} = stat(i).ipix;
end
data.ROIs = x;
clear x
data.overlay = zeros(size(ops.mimg,1),size(ops.mimg,2));
data.overlay(vertcat(data.ROIs{:})) = 1;
data.stats = CaStats(data.fluo);


warning ('on','all');
end