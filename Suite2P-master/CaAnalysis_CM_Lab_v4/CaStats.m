function [stats] = CaStats(data)

% data = rand(1000,1); %random data to be replaced with actual data
% data(100:150) = 2;

[r,c] = size(data); %get size of data set. r:frames, c:cells
figure
% hold on
eventlog = zeros(r,c);  %initialize event log for binary events
active = zeros(c,1);    %binary for which cells are active: 1 = at least one detected spike
for i = 1:c
    %Calculate baseline
    temp = smooth(data(:,i),20,'moving');
    temp = temp(2:end-14);
    temp = temp-min(temp);
    baseline = mean(temp(temp<(std(temp)*2.5+mean(temp))));
    dFF = smooth((temp-baseline)/baseline,5,'moving');  %Calculate dFF using calculated baseline then smooth using a 5 frame moving average
    ddFF = diff(dFF);   %First derivitave of the the dF/F data
%     thresh = std(dFF(2:end)<(std(dFF(2:end))*2.5+mean(dFF(2:end))))*2.5;
    thresh1 = std(ddFF(2:end))*2.5;  %Set threshold as 2.5 x standard deviation
    thresh2 = (mean(dFF(2:end))+std(dFF(2:end))*2.5);
    events = logical(ddFF>thresh1) & logical(dFF(2:end)>thresh2); %Detect as event when both ddFF>2.5*std and dFF>mean+2.5*STD (Top 99%)
    
%     events = logical([0; diff(double(events))>0]);    %Get rid of any continuous detections and only keep the onset of the event (NOT SURE IF WE WANT TO KEEP)
    
    eventlog(events,i) = 1; % Write events into event log
    
    %Plot traces for Raw Data, dF/F and ddF/F
    subplot(4,1,1)
    plot(temp)
    title('Raw Fluorescence')
    xlim([0 r])
    subplot(4,1,2)
    plot(dFF)
    title('dF/F')
    hold on
    plot([1 r],[thresh2 thresh2],'--')
    hold off
    xlim([0 r])
    subplot(4,1,3)
    plot(ddFF)
    title('dF/F''')
    hold on
    plot([1 r],[thresh1 thresh1],'--')
    hold off
    xlim([0 r])
    ylim([min(ddFF) max(ddFF)])
    subplot(4,1,4)
    plot(events)
    title('Detected Events')
    active(i) = logical(sum(events));
    xlim([0 r])
    ylim([0 1.5])
    drawnow()
    pause(.1)

% plot(find(events),zeros(length(find(events)))+i,'x')

end
active = find(active);

binSize = 8;
eventlog_bin = zeros(ceil(r/binSize),c);
count = 1;
try
    for i = 1:binSize:r
        eventlog_bin(count,:) = logical(sum(eventlog(i:i+binSize-1,:)));
        count = count+1;
    end
catch
    eventlog_bin(count,:) = logical(sum(eventlog(i:end,:)));
end


figure
hold on
for i = 1:c
    title('Detected Events')
    xlabel('Frames')
    ylabel('ROI #')
    plot(find(eventlog_bin(:,i)),zeros(length(find(eventlog_bin(:,i))))+i,'x')
end

%% actual stats

eventlog_active = eventlog_bin(:,active);

dist = pdist(eventlog_active','cosine');
mean_dist = mean(dist);
figure
imshow(squareform(dist))
title('Pairwise P-Distances')

cross_corr = corrcoef(eventlog_active);
figure
image(cross_corr*100) %multiplied by 100 to visualize
colormap hot

x = 0:.01:1;
y = zeros(1,length(x));
for i = 1:length(x)
    y(i) = sum(dist<=x(i))./length(dist);
end
figure
plot(x,y*100)
title('Cumulative Histogram of p-dist Values (Active ROIs)')
xlabel('p-distance (cosine)')
ylabel('Percentage of ROIs')
ylim([0 10])

stats.eventLog = eventlog;
stats.eventLog_bin = eventlog_bin;
stats.eventLog_active = eventlog_active;
stats.activeCells = active;
stats.pdist_active = dist;
stats.pdist_hist = [x' y'];
stats.crossCorr = cross_corr;


end



