figure
hold on

numitr = 1000;

tempDat = data.stats.eventLog_active;
shuffle_x_corrs = zeros(size(tempDat,2),size(tempDat,2),numitr);

for i = 1:numitr
    shuffle_x_corrs(:,:,i) = corrcoef(shuffle(tempDat));
end

%% original_coeff

%turn cross correlation matrix into single vector
temp = data.stats.crossCorr;
temp = triu(temp,1);
temp = temp(temp~=0);


%Check if any zero values were accidently removed
checksum = size(shuffle_x_corrs,1);
checksum = (checksum^2-checksum)/2;
if length(temp)~=checksum
    temp = [temp;zeros(checksum-length(temp),1)];
end
temp = flip(sort(temp));
bins = length(temp)/100;
bins = bins:bins:length(temp);
bins = round(bins);

for j = 1:100
    bins(j) = mean(temp(1:bins(j)));
end
original_coeff = bins;



%%
coeffs = zeros(numitr,100);

for i = 1:numitr
    
    %turn cross correlation matrix into single vector
    temp = shuffle_x_corrs(:,:,i);
    temp = triu(temp,1);
    temp = temp(temp~=0);
    
    
    %Check if any zero values were accidently removed
    checksum = size(shuffle_x_corrs,1);
    checksum = (checksum^2-checksum)/2;
    if length(temp)~=checksum
        temp = [temp;zeros(checksum-length(temp),1)];
    end
    temp = flip(sort(temp));
    bins = length(temp)/100;
    bins = bins:bins:length(temp)';
    bins = round(bins);
    
    for j = 1:100
        bins(j) = mean(temp(1:bins(j)));
    end
    coeffs(i,:) = bins;
    %     figure
    %     plot(bins)
    %     xlabel('Percentile (most correlated)')
    %     ylabel('Mean Correlation Coefficient')
    %     coeffs(:,i) = bins;
end


meanC = mean(coeffs);
stdC = std(coeffs);
varC = var(coeffs);
min5C = meanC-stdC.*2;
max5C = meanC+stdC.*2;


plot(original_coeff,'m','LineWidth', 3)
plot(min5C,'b-','LineWidth',3)
plot(max5C,'b-','LineWidth',3)
fill([1:100 flip(1:100)],[min5C fliplr(max5C)],'b')
plot(meanC,'y-','LineWidth',1)
xlabel('Percentile (most correlated)')
ylabel('Mean Correlation Coefficient')
legend({'Original Data' '95% Confidence Interval of Randomized Data'})
axis([0 100 0 .85])
title(num2str(numitr))
set(gca,'FontSize',24)
pause(0.12)
