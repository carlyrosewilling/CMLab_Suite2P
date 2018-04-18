%%Post-Registration Pipeline%%

%% What To Run
    %select 1 for yes, 0 for no


viewBinaries        = 0; %view registered binaries
alreadyprocessed    = 1;
runGUI              = 1; %hand curate ROIs
activecellsonly     = 1; %runs analysis with active cells (as specified by classifier) only, 
                            %switch to 0 for all cells
meanimagecells      = 0; %view mean image with ROIs overlayed
plot_average        = 0; %plot average calcium and neuropil traces for active cells
plot_cellTraces     = 1; %view plots of all active cell 
runbatchanalysis    = 1; %run batch analysis for spike inference
retrieve_stats      = 1; %only select if run batch analysis, retrieves stats from that function call
plot_eventLog       = 0; %view event log


%% Load File
addpath(genpath(fullfile('J:', 'Data 2018', 'Suite2P_Data+Analysis', 'MATLAB')));   %Change as needed to match containing MATLAB folder 
file_specifier;
ops = ops0;
make_db;
load(fullfile(sprintf('%s/regops_%s_%s.mat', ops.ResultsSavePath, db.mouse_name, db.date)); %ops file
iplane = ops1{1,1}.planesToProcess;

if alreadyprocessed == 1
    load(fullfile(ops.ResultsSavePath, sprintf('F_%s_%s_plane%d_proc.mat', db.mouse_name, db.date, iplane); %processed registered F*.mat file
else
    load(fullfile(ops.ResultsSavePath, sprintf('F_%s_%s_plane%d.mat', db.mouse_name, db.date, iplane); %unprocessed registered F*.mat file
end 


%% Function Calls

%------View Binaries------%
if viewBinaries == 1;
    view_registered_binaries(ops1)
end

%------Run Hand-Curation GUI------%
if runGUI == 1;
    new_main 
    load(fullfile(ops.ResultsSavePath, sprintf('F_%s_%s_plane%d_proc.mat', db.mouse_name, db.date, iplane)));
end 

%------Plot Mean Image and Active Cells------%
if meanimagecells == 1;
    mimgandcells(ops1, dat)
end 

%------Plot Average Calcium Traces------%
if plot_average == 1;
    if activeonly == 1;
        timecourse(ops1, dat, 1)
    else
        timecourse(ops1, dat, 0)
    end
end 

%------Plot Calcium Traces Per Active Cell------%
if plot_cellTraces == 1;
    if activeonly == 1
        subplots(dat, 1)
    else 
        subplots(dat, 0)
    end
end

%------Run Batch Analysis------%
if runbatchanalysis == 1
    if activeonly == 1
        saveDir = batchAnalysis(ops1, 1);
    else
        saveDir = batchAnalysis(ops1, 0);
    end
end 

%------Retrieve Batch Analysis Stats------%
if retrieve_stats == 1
    filelist = retrieveStats(saveDir)
end 

%------Plot Event Log------%
if plot_eventLog == 1
    plot_eventlog(filelist)
end

