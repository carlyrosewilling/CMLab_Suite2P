function filelist = retrieveStats(directory)

folder = directory;
filelist = dir(fullfile(folder,'*.mat'));
filelist = rmfield(filelist,{'folder','date','bytes','isdir','datenum'});

for i = 1:length(filelist)
    load(fullfile(folder,filelist(i).name));
    filelist(i).fluo = data.fluo;
    filelist(i).stats = data.stats;
    clear data
end

figure; hold on; for i = 1:8; plot(filelist(i).stats.pdist_hist(:,1),filelist(i).stats.pdist_hist(:,2));end; hold off
figure; hold on; for i = 9:14; plot(filelist(i).stats.pdist_hist(:,1),filelist(i).stats.pdist_hist(:,2));end; hold off
    