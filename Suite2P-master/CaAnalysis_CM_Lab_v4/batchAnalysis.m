function saveDir = batchAnalysis(ops, active)
%Batch analysis of outputs from Suite2P

warning ('off','all'); %Turn off warnings because they get annoying (Eventually turn off specific warnings)
ops = ops{1};
base2 = fullfile(ops.ResultsSavePath);
%base2 = uigetdir;   %Get user input for directory location
matNames = dir(fullfile(base2,'*_proc.mat'));    %Find all matfiles in the folder
matNames = rmfield(matNames,{'date' 'bytes' 'isdir' 'datenum'});
errCount = 0;   %initiliaze number of errors
errorLog = [];  %initilize error log
saveDir = fullfile(base2,'stats'); %create save directory name
mkdir(saveDir);   %Create directory for saving data

% Loop through all files
for i = 1:length(matNames)
%     try
        close all
        fullFileN = fullfile(matNames(i).folder,matNames(i).name);  %Get full file path
        load(fullFileN,'dat')  %Load necessary files from Suite2P mat file
        stat = dat.stat; %Converts from Suite2p output structure to easily accessible structure
        ops = dat.ops;
        Fcell = dat.Fcell{1};
        if active == 1
            index = find(vertcat(stat(:).iscell)); %Find which of the possible ROIs have been labeled cells
            stat = stat(index); %use only stats for cells
            Fcell = Fcell(index, :); %use only Fcell for cells 
        else
            stat = stat;
            Fcell = Fcell;
        end
        data = suite2p_convert(stat, ops, Fcell); %Convert data from Suite2P format to necessary data structure
        [matName,~] = strtok(matNames(i).name,'.'); %Grab file name w/o extention
        matName = fullfile(saveDir,[matName '_stats.mat']); %Create save file name
        save(matName,'data','-v7.3')    %Save data in mat file (same name but appended with '_stats.mat')
        clear data  %clear all data from memory
%     catch ME
%         % If error occurs, display which file failed and log into error log
%         errCount = errCount+1;
%         sprintf('Unable to process %s in the following path:\n%s',...
%             matNames(i).name,matNames(i).folder)
%         errorLog(errCount).fileName = matNames(i).name;
%         errorLog(errCount).filePath = matNames(i).folder;
%         errorLog(errCount).error = ME;
%     end
end
warning ('on','all');   %turn warnings back on
end