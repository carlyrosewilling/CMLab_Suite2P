%Find distance between each cell on the ROI image 
%Relate the distance with the correlation coefficient data to find the Pearson's Correlation Coefficient
%Plot with 10 bins
%Input is the ROIs image and the correlation coefficient data

load('D:\Users\Carly Rose\Desktop\Suite2P\DATA\Registered_Planes\LK022118_1\2018-04-27\3\F_LK022118_1_2018-04-27_plane1_proc.mat')
load('D:\Users\Carly Rose\Desktop\Suite2P\DATA\Registered_Planes\LK022118_1\2018-04-27\3\stats\F_LK022118_1_2018-04-27_plane1_proc_stats.mat')

%This is a temp to find the centroid of each ROI
 %CC = bwconncomp(data.overlay);
 %centrumdata = regionprops(CC,'Centroid');
centrumdata = horzcat(dat.stat.med);
 %This is to transfer data in the struct to a cell
 %cellcentrum = struct2cell(centrum);
 %centrumdata = cell2mat(cellcentrum);
 
 %This is to transfer data in the cell to a matrix
matrixcentrum = zeros(length(data.ROIs),2); 
 for i=1:length(data.ROIs)
     matrixcentrum(i,2)=centrumdata(1,2*i);
     matrixcentrum(i,1)=centrumdata(1,2*i-1);
 end;
 
%Find distance between each centroid, generating a matrix (length(data.ROIs))
distance = zeros(length(data.ROIs),1);
matrixdistanceforall = zeros(length(data.ROIs));
 for j=1:length(data.ROIs)
    for i =1:length(data.ROIs)
        distance(i,1)=sqrt((matrixcentrum(j,1)-matrixcentrum(i,1))^2+(matrixcentrum(j,2)-matrixcentrum(i,2))^2);
    end;
    matrixdistanceforall(j,:)=distance;
 end

 %to count how many elements are in the upper triangular part of
 %matrixdistanceforall
 for ii=length(matrixdistanceforall(1,:))-1
     s=sum(1:ii);
 end
 
 %to locate indecis of elements in the upper triangular part
indecist=find(triu(matrixdistanceforall)>0);
 
 %to exact elements in the upper triangular part of matrixdistanceforall to
 %a column vector in the order of linear indexing
vectordistanceforall=zeros(length(indecist),1);
 for i=1:length(indecist)
     vectordistanceforall(i,1)=matrixdistanceforall(indecist(i));
 end
 
 %to convert the upper tiangular part of correlation coefficient to a
 %column vector in the order of linear indexing 
 
vectorcorrcoeff=zeros(length(indecist),1);
corr_coeff=data.stats.crossCorr;
 
 for i=1:length(data.ROIs)
     corr_coeff(i,i)=0;
     for j = 1:length(data.ROIs)-i
         corr_coeff(j+i,i) = corr_coeff(i, j+i);
     end
 end
 


 for i=1:length(indecist)
     vectorcorrcoeff(i,1)=corr_coeff(indecist(i));
 end
 
%to combime those to vectors above
disco=[vectordistanceforall,vectorcorrcoeff];
binSize = 50;

bins = 0:binSize:max(disco(:,1));
bins = [bins max(disco(:,1))];

binnedDat = zeros(length(bins)-1,1);
binnedwbin = [];

for binNum = 1:length(bins)-1 
    binnedDat(binNum) = mean(disco(disco(:,1)>bins(binNum) & disco(:,1)<=bins(binNum+1),2));
    binnedwbin = [binnedwbin; binNum length(disco(disco(:,1)>bins(binNum) & disco(:,1)<=bins(binNum+1),2)) binnedDat(binNum)];
end

%%Plotting

figure;
plot(bins(2:length(bins)), binnedDat)
title('Distribution of Cell Distance v. Correlation');
ylabel('Correlational Coefficient');
xlabel('Distance Between Cells (pixels)');

figure;
[counts, bins] = hist(vectorcorrcoeff);
hist(vectorcorrcoeff);
axis([-0.05 max(bins)+0.08 0 max(counts)+(.2*max(counts))])
title('Number of Cells Per Correlational Coefficient');
ylabel('Number of Cells');
xlabel('Correlational Coefficient');



