figure
hold on
coeffs = zeros(100,length(filelist));
for i = 1:length(filelist)

    %turn cross correlation matrix into single vector
    temp = filelist(i).stats.crossCorr;
    temp = triu(temp,1);
    temp = temp(temp~=0);


    %Check if any zero values were accidently removed
    checksum = length(filelist(i).stats.activeCells);
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

%     figure
    plot(bins)
    xlabel('Percentile (most correlated)')
    ylabel('Mean Correlation Coefficient')
    coeffs(:,i) = bins;
end
hold off
coeff1 = coeffs(:,1:8);
coeff2 = coeffs(:,9:14);
mcoeff1 = mean(coeff1');
sem1 = std(coeff1,[],2)/sqrt(length(coeff1(1,:)));  
sem2 = std(coeff2,[],2)/sqrt(length(coeff2(1,:)));  
mcoeff2 = mean(coeff2');
figure
errorbar(mcoeff1,sem1)
hold on
errorbar(mcoeff2,sem2)
hold off
xlabel('Percentile (most correlated)')
ylabel('Mean Correlation Coefficient')


