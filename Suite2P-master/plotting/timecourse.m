function timecourse(ops, data, active)


%For some reason, sometimes MATLAB/Suite2P decides that the dat structure
    %is weird. If you get an error that says 
    %"Reference to non-existent field 'stat'."
    %change anything that is "dat." below, to "dat.dat." and vice versa
if active == 1
    index = find(vertcat(data.stat(:).iscell));
    spikes = data.sp{1,1}(index,:);
    Fspikes = data.Fcell{1,1}(index,:);
    Nspikes = data.FcellNeu{1,1}(index, :);
    numcellstot = length(Fspikes(:,1));
    time = length(Fspikes);
else
    spikes = data.sp{1,1};
    Fspikes = data.Fcell{1,1};
    Nspikes = data.FcellNeu{1,1};
    numcellstot = length(data.stat);
    time = length(Fspikes);
end 

averagecalcium = [];
for i = 1:time
    averagecalcium(i) = mean(Fspikes(:,i));
end

averageneuropil = [];
for i = 1:time
    averageneuropil(i) = mean(Nspikes(:,i));
end

subplot(2,1,1)
plot(averagecalcium)
axis([0 time min(averagecalcium)-5 max(averagecalcium)+5]);
title('Average Calcium Traces');
subplot(2,1,2)
plot(averageneuropil)
axis([0 time min(averagecalcium)-5 max(averagecalcium)+5]);
title('Average Neuropil Traces');

figure
plot(averagecalcium)
hold on;
plot(averageneuropil)
axis([0 time min(averagecalcium)-5 max(averagecalcium)+5]);
title('Average Calcium and Neuropil Traces')
legend('Calcium', 'Neuropil')


%maximums = [];
%minimums = [];
%for j = 1:numcellstot
    %maximums(j) = max(Fspikes(j,:));
    %minimums(j) = min(Fspikes(j,:));
%end 
