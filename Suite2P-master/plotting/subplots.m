
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%---------------------------Subplots---------------------------%%
%-Plots the deltaF/F courses of ROIs as determined by classifier-%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----------------Written by: Carly Rose Willing-----------------%

function subplots(dat, active)
%Input must be F*.mat data structure obtained from registration

%For some reason, sometimes MATLAB/Suite2P decides that the dat structure
    %is weird. If you get an error that says 
    %"Reference to non-existent field 'stat'."
    %change anything that is "dat." below, to "dat.dat." and vice versa

if active == 1;
    index = find(vertcat(dat.stat(:).iscell));
    spikes = dat.sp{1,1}(index,:);
    Fspikes = dat.Fcell{1,1}(index,:);
    numcellstot = length(Fspikes(:,1));
    time = length(Fspikes);
else
    spikes = dat.sp{1,1};
    Fspikes = dat.Fcell{1,1};
    numcellstot = length(dat.stat);
    time = length(Fspikes);
end 

stringwnum = strcat('There are: ', num2str(numcellstot), ' cells. Would you like to plot them evenly across 10 plots? Y/N [Y]: ');
input1 = input(stringwnum, 's');
if input1 == 'Y'
    intdivise = floor(numcellstot/10);
    numcells1 = intdivise;
    numcells2 = intdivise;
    numcells3 = intdivise;
    numcells4 = intdivise;
    numcells5 = intdivise;
    numcells6 = intdivise;
    numcells7 = intdivise;
    numcells8 = intdivise;
    numcells9 = intdivise;
    numcells10 = numcellstot - (9*intdivise);
elseif input1 == 'N'
    numcells1 = input('Number of cells for plot 1:');
    numcells2 = input('Number of cells for plot 2:');
    numcells3 = input('Number of cells for plot 3:');
    numcells4 = input('Number of cells for plot 4:');
    numcells5 = input('Number of cells for plot 5:');
    numcells6 = input('Number of cells for plot 6:');
    numcells7 = input('Number of cells for plot 7:');
    numcells8 = input('Number of cells for plot 8:');
    numcells9 = input('Number of cells for plot 9:');
    numcells10 = input('Number of cells for plot 10:');
    
else
    warning('No valid selection was made; assuming yes');
    intdivise = floor(numcellstot/10);
    numcells1 = intdivise;
    numcells2 = intdivise;
    numcells3 = intdivise;
    numcells4 = intdivise;
    numcells5 = intdivise;
    numcells6 = intdivise;
    numcells7 = intdivise;
    numcells8 = intdivise;
    numcells9 = intdivise;
    numcells10 = numcellstot - (9*intdivise);
    
end

figure;
hold on;
for i = numcells1:-1:1
    temp = Fspikes(i,:);
    plot(temp./max(temp)+ i, 'DisplayName', int2str(index(i)));;
    set(gca, 'xtick', [], 'ytick', [], 'box', 'off', 'XTickLabel', [], 'Yticklabel', []);
    axis([0 time 0 numcells1+2]);
    hold on;
end
legend('show', 'Location', 'westoutside');
hold off;

total = numcells1;

if total+numcells2 > numcellstot
    warning('Not enough cells to plot, please plot fewer');
    cellsleft = numcellstot - total;
    errorstr = strcat('There are ', num2str(cellsleft), ' cells left');
    warning(errorstr);
    numcells2 = input('Number of cells for plot two:');
end

figure;
hold on;
for j = numcells2:-1:1
    temp = Fspikes(total + j,:);
    plot(temp./max(temp)+ j, 'DisplayName', int2str(index(total+j)));
    set(gca, 'xtick', [], 'ytick', [], 'box', 'off', 'XTickLabel', [], 'Yticklabel', []);
    axis([0 time 0 numcells2+2]);
    hold on;
end
legend('show', 'Location', 'westoutside')
hold off;

total = total + numcells2;

if total+numcells3 > numcellstot
    warning('Not enough cells to plot, please plot fewer');
    cellsleft = numcellstot - total;
    errorstr = strcat('There are ', num2str(cellsleft), ' cells left');
    warning(errorstr);
    numcells3 = input('Number of cells for plot three:');
end

figure;
hold on;
for k = numcells3:-1:1
    temp =  Fspikes(total + k,:);
    plot(temp./max(temp)+k, 'DisplayName', int2str(index(total+k)));
    set(gca, 'xtick', [], 'ytick', [], 'box', 'off', 'XTickLabel', [], 'Yticklabel', []);
    axis([0 time 0 numcells3+2]);
    hold on;
end
legend('show', 'Location', 'westoutside')
hold off;

total = total + numcells3;

if total+numcells4 > numcellstot
    warning('Not enough cells to plot, please plot fewer');
    cellsleft = numcellstot - total;
    errorstr = strcat('There are ', num2str(cellsleft), ' cells left');
    warning(errorstr);
    numcells4 = input('Number of cells for plot four:');
end

figure;
hold on;
for m = numcells4:-1:1
    temp =  Fspikes(total + m,:);
    plot(temp./max(temp)+ m, 'DisplayName', int2str(index(total+m)));
    set(gca, 'xtick', [], 'ytick', [], 'box', 'off', 'XTickLabel', [], 'Yticklabel', []);
    axis([0 time 0 numcells4+2]);
    hold on;
end
legend('show', 'Location', 'westoutside')
hold off;

total = total + numcells4;

if total+numcells5 > numcellstot
    warning('Not enough cells to plot, please plot fewer');
    cellsleft = numcellstot - total;
    errorstr = strcat('There are ', num2str(cellsleft), ' cells left');
    warning(errorstr);
    numcells5 = input('Number of cells for plot five:');
end

figure;
hold on;
for n = numcells5:-1:1
    temp =  Fspikes(total + n,:);
    plot(temp./max(temp)+ n, 'DisplayName', int2str(index(total+n)));
    set(gca, 'xtick', [], 'ytick', [], 'box', 'off', 'XTickLabel', [], 'Yticklabel', []);
    axis([0 time 0 numcells5+2]);
    hold on;
end
legend('show', 'Location', 'westoutside')
hold off;

total = total + numcells5;

if total+numcells6 > numcellstot
    warning('Not enough cells to plot, please plot fewer');
    cellsleft = numcellstot - total;
    errorstr = strcat('There are ', num2str(cellsleft), ' cells left');
    warning(errorstr);
    numcells6 = input('Number of cells for plot six:');
end


        
figure;
hold on;
for p = numcells6:-1:1
    temp =  Fspikes(total + p,:);
    plot(temp./max(temp)+ p, 'DisplayName', int2str(index(total + p)));
    set(gca, 'xtick', [], 'ytick', [], 'box', 'off', 'XTickLabel', [], 'Yticklabel', []);
    axis([0 time 0 numcells6+2]);
    hold on;
end
legend('show', 'Location', 'westoutside')
hold off;

total = total + numcells6;

if total+numcells7 > numcellstot
    warning('Not enough cells to plot, please plot fewer');
    cellsleft = numcellstot - total;
    errorstr = strcat('There are ', num2str(cellsleft), ' cells left');
    warning(errorstr);
    numcells7 = input('Number of cells for plot seven:');
    
end

        
figure;
hold on;
for q = numcells7:-1:1
    temp =  Fspikes(total + q,:);
    plot(temp./max(temp)+ q, 'DisplayName', int2str(index(total + q)));
    set(gca, 'xtick', [], 'ytick', [], 'box', 'off', 'XTickLabel', [], 'Yticklabel', []);
    axis([0 time 0 numcells7+2]);
    hold on;
end
legend('show', 'Location', 'westoutside')
hold off;

total = total + numcells7;

if total+numcells8 > numcellstot
    warning('Not enough cells to plot, please plot fewer');
    cellsleft = numcellstot - total;
    errorstr = strcat('There are ', num2str(cellsleft), ' cells left');
    warning(errorstr);
    numcells8 = input('Number of cells for plot eight:');
    
end


figure;
hold on;
for r = numcells8:-1:1
    temp =  Fspikes(total + r,:);
    plot(temp./max(temp)+ r, 'DisplayName', int2str(index(total + r)));
    set(gca, 'xtick', [], 'ytick', [], 'box', 'off', 'XTickLabel', [], 'Yticklabel', []);
    axis([0 time 0 numcells8+2]);
    hold on;
end
legend('show', 'Location', 'westoutside')
hold off;

total = total + numcells8;

if total+numcells9 > numcellstot
    warning('Not enough cells to plot, please plot fewer');
    cellsleft = numcellstot - total;
    errorstr = strcat('There are ', num2str(cellsleft), ' cells left');
    warning(errorstr);
    numcells9 = input('Number of cells for plot nine:');
    
end

        
figure;
hold on;
for s = numcells9:-1:1
    temp =  Fspikes(total + s,:);
    plot(temp./max(temp)+ s, 'DisplayName', int2str(index(total + s)));
    set(gca, 'xtick', [], 'ytick', [], 'box', 'off', 'XTickLabel', [], 'Yticklabel', []);
    axis([0 time 0 numcells9+2]);
    hold on;
end
legend('show', 'Location', 'westoutside')
hold off;

total = total + numcells9;

if total+numcells10 > numcellstot
    warning('Not enough cells to plot, please plot fewer');
    cellsleft = numcellstot - total;
    errorstr = strcat('There are ', num2str(cellsleft), ' cells left');
    warning(errorstr);
    numcells10 = input('Number of cells for plot ten:');
    
end

        
figure;
hold on;
for t = numcells10:-1:1
    temp =  Fspikes(total + t,:);
    plot(temp./max(temp)+ t, 'DisplayName', int2str(index(total + t)));
    set(gca, 'xtick', [], 'ytick', [], 'box', 'off', 'XTickLabel', [], 'Yticklabel', []);
    axis([0 time 0 numcells10+2]);
    hold on;
end
legend('show', 'Location', 'westoutside')
hold off;

total = total + numcells10;

if total < numcellstot
    warning(strcat('You are not including all available cells. Cells left:', int2str(numcellstot-total)));
    prompt3 = 'Would you like to include the remaining cells? Y/N [Y]:';
    input3 = input(prompt3, 's');
    if input3 == 'N'
        warning('Plots do not contain all cells');
    else
        figure
        for u = numcellstot - total:-1:1
            temp =  Fspikes(total + u,:);
            plot(temp./max(temp)+ u, 'DisplayName', int2str(index(total + u)));
            set(gca, 'xtick', [], 'ytick', [], 'box', 'off', 'XTickLabel', [], 'Yticklabel', []);
            axis([0 time 0 numcellstot-total+2]);
            hold on;
        end
    end
end

            