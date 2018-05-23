%%File Specifier%%
    %fill out and run before running any script
    %files here are called in master_file_complete 
    
ops0.driveletter = 'D:';
ops0.drivefolder = 'Users\Carly Rose\Desktop';
ops0.expfolder = 'Suite2P';
ops0.datafolder = 'DATA';
ops0.planesfolder = 'Registered_Planes';
ops0.tifffolder = 'Registered_Tiffs';
ops0.matlabfolder = 'MATLAB';
ops0.suite2pfolder = 'Suite2P-master';
ops0.oasispath = 'OASIS_matlab-master';

addpath(genpath(fullfile(ops0.driveletter, ops0.drivefolder, ops0.expfolder)));

%Don't touch these
ops0.RootStorage            = fullfile(ops0.driveletter, ops0.drivefolder, ops0.expfolder, ops0.datafolder);
ops0.ResultsSavePath        = fullfile(ops0.driveletter, ops0.drivefolder, ops0.expfolder, ops0.datafolder, ops0.planesfolder);