function spiketimes = plot_eventlog(filelist)

spiketimes = [];
for i = 1:size(filelist.stats.eventLog, 1)
    spiketimes(i) = sum(filelist.stats.eventLog(i,:));
end
bins = 8;
edges = 1:bins:length(spiketimes);

plot(spiketimes)
axis([0 length(spiketimes) 0 max(spiketimes)+3])
ylabel('Number of cells firing');
xlabel('Frame');
title('Firing Rate of Cells');

[a, b] = max(spiketimes);
cellnumbers = find(filelist.stats.eventLog(b, :) == 1);
cellnumbers2 = find(filelist.stats.eventLog(b+1, :) == 1);
cellnumbers3 = find(filelist.stats.eventLog(b-1, :) == 1);
cellnumbers4 = find(filelist.stats.eventLog(b-4, :) == 1);
cellnumbers5 = find(filelist.stats.eventLog(b-3, :) == 1);
cellnumbers6 = find(filelist.stats.eventLog(b-2, :) == 1);
cellnumbers7 = find(filelist.stats.eventLog(b+2, :) == 1);
cellnumbers8 = find(filelist.stats.eventLog(b+3, :) == 1);



cellnum = [cellnumbers cellnumbers2 cellnumbers3 cellnumbers4 cellnumbers5 cellnumbers6 cellnumbers7 cellnumbers8];
cellnum = unique(cellnum, 'first');
finalcellnum = sort(cellnum);
chosencells = filelist.fluo(:, finalcellnum);


figure

for i = length(finalcellnum):-1:1
    temp = chosencells(:,i);
    plot(temp./max(temp)+ i, 'DisplayName', int2str(finalcellnum(i)));
    set(gca, 'ytick', [], 'box', 'off', 'Yticklabel', []);
    axis([0 length(filelist.fluo) 0 length(finalcellnum)+2]);
    xlabel('Frame')
    title('Calcium Traces')
    hold on;
end
legend('show', 'Location', 'westoutside');

grey = [0.4 0.4 0.4];
p = patch([b-300 b+300 b+300  b-300], [0 0 length(finalcellnum)+2 length(finalcellnum)+2], grey, 'LineStyle', 'none', 'FaceAlpha', .2);
p.Annotation.LegendInformation.IconDisplayStyle = 'off';

p = patch([b-300 b+300 b+300  b-300], [0 0 length(finalcellnum)+2 length(finalcellnum)+2], grey, 'LineStyle', 'none', 'FaceAlpha', .2);
p.Annotation.LegendInformation.IconDisplayStyle = 'off';

cellT = chosencells';

[r c] = size(filelist.stats.eventLog);

binSize = 8;
eventlog_bin = zeros(1,ceil(r/binSize));
count = 1;
for i = 1:binSize:r
    eventlog_bin(:,count) = sum(spiketimes(:, i:i+binSize-1));
    count = count+1;
end

figure
plot(eventlog_bin)
axis([0 length(eventlog_bin) 0 max(eventlog_bin)+3])
ylabel('Number of cells firing');
xlabel('Frame');
title('Binned Firing Rate of Cells');
