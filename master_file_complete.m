%% Initialization
    %Note: defaults can be changed for individual experiments via make_db files

%------Run File Specifier------%
file_specifier;

%------Path to make_db file------%
%General path to Data, MATLAB scripts, OASIS toolbox
addpath(genpath(fullfile(ops0.driveletter, ops0.drivefolder, ops0.expfolder, ops0.matlabfolder, ops0.suite2pcontaining)));
make_db; %run DB file here -- instructions/options for DB are in make_db
         %DB's can be numbered so that each day a unique DB is made

%------Paths to Suite2P Toolbox and OASIS------%
ops0.toolbox_path = fullfile(ops0.driveletter, ops0.drivefolder, ops0.expfolder, ops0.matlabfolder, ops0.suite2pcontaining);
if exist(ops0.toolbox_path, 'dir')
	addpath(genpath(ops0.toolbox_path)); %path to toolbox
else
	error('toolbox_path does not exist, please change toolbox_path');
end

addpath(genpath(fullfile(ops0.driveletter, ops0.drivefolder, ops0.expfolder, ops0. matlabfolder, ops0.suite2pcontaining, ops0.oasispath))); %Path to OASIS

%% Setting Options
    %Note: If you want to use L0 spike deconv, you must load mex file via the following line
%mex -largeArrayDims OASIS_matlab-master/SpikeDetection/deconvL0.c (or.cpp) %Need to have visual studio installed -- haven't really figured it out yet

ops0.useGPU                 = 1; % Set to 1 to accelerate registration: Nvidia GPU only, other GPUs won't work
ops0.fig                    = 1; %1 to generate figure, 0 to turn off  
ops0.diameter               = 12; %MOST IMPORTANT PARAMETER. Set here, or individually per experiment in make_db file
ops0.nplanes                = 1; %number of planes to be processed

%------Root Paths for Files and Temporary Storage------
ops0.RootStorage            = fullfile(ops0.driveletter, ops0.drivefolder, ops0.expfolder, ops0.datafolder); %root location where the raw tiff files are stored
        %Suite2P assumes a folder structure, check out README file(although not very helpful)
        %Basically, in order of folders, it should be
        %containing folder, here DATA -> mouse name -> date -> area -> tiff files
            %check make_db file for more detailed explanation of file structure
ops0.temp_tiff              = []; %leave as [] if you do not want to save temporary tiff 
ops0.readTiffHeader         = 0; %0 to avoid complicated tiff tags
ops0.RegFileRoot            = fullfile(ops0.driveletter, ops0.drivefolder, ops0.expfolder, ops0.datafolder); %location where to keep registered movies in binary format
ops0.DeleteBin              = 0; % set to 1 to delete binarys after registration 
                                 %(saves (a limited amount of) space, but then runs registration each time
                                 %so basically do you wanna save time or save space?)
ops0.ResultsSavePath        = fullfile(ops0.driveletter, ops0.drivefolder, ops0.expfolder, ops0.datafolder, ops0.planesfolder); %where to save data results (i.e. F*.mat file)
ops0.RegFileTiffLocation    = fullfile(ops0.driveletter, ops0.drivefolder, ops0.expfolder, ops0.datafolder, ops0.tifffolder); %where to save registered tiffs 
                                            % leave empty to NOT save registered tiffs
addpath(ops0.RegFileRoot);
%------Registration Options------
ops0.doRegistration         = 1; %set to 0 to NOT run registration, if registration is already done
ops0.getROIs                = 1; %set to 0 if you ONLY want to register
ops0.showTargetRegistration = 1; %shows the mean image targets for all planes to be registered
ops0.PhaseCorrelation       = 1; %set to 0 for non-whitened cross-correlation
ops0.SubPixel               = Inf; %2 is alignment by 0.5 pixel, Inf is the exact number from phase correlation
ops0.NimgFirstRegistration  = 1000; %number of images to include in the first registration pass 
ops0.nimgbegend             = 0; %frames to average at beginning and end of blocks
ops0.dobidi                 = 1; %1 to infer and apply bidirectional phase offset
%ops0.BiDiPhase              = ; %value of bidirectional phase offset to use for computation-- only if not using dobidi=1
%ops0.maxregshift            = 20; %maximum amount of movement allowed in FOV (defaults to 10% max(y pixels, x pixels)

%------Cell Detection Options------
ops0.ShowCellMap            = 1; %during optimization, show a cluster figure
ops0.sig                    = 1;  %spatial smoothing length in pixels; encourages localized clusters
ops0.nSVDforROI             = 1000; %how many cells expected
ops0.NavgFramesSVD          = 5000; %how many (binned) timepoints to do the SVD based on
ops0.signalExtraction       = 'surround'; %how to extract ROI and neuropil signals: 
%  'raw' (no cell overlaps), 'regression' (allows cell overlaps), 
%  'surround' (no cell overlaps, surround neuropil model)

%------Neurophil Options (only if using 'surround' for signal extraction)------
%All are in measurements of pixels
ops0.innerNeuropil          = 1; %padding around cell to exclude from neuropil
ops0.outerNeuropil          = Inf; %radius of neuropil surround
                                   %if Inf, then neuropil surround radius is a function of cell size
ops0.maxNeurop              = 1; %for the neuropil contamination to be less than this (sometimes good, i.e. for interneurons)


if isinf(ops0.outerNeuropil)
    ops0.minNeuropilPixels  = 400; %minimum number of pixels in neuropil surround
    ops0.ratioNeuropil    	= 5; %ratio between neuropil radius and cell radius -- README explains more
    %radius of surround neuropil = ops0.ratioNeuropil * (radius of cell)
end

%------Spike Deconvolution and Neuropil Subtraction Options------
ops0.deconvType             = 'OASIS'; %'L0' if using other deconv method
ops0.imageRate              = 30;  %approximate imaging rate in Hz
ops0.sensorTau              = 0.5; %approximate decay half-life (or timescale

%------IF YOU HAVE RED CHANNEL------
ops0.AlignToRedChannel      = 1; %set to 1 to register movement to red channel
ops0.REDbinary              = 1; %set to 1 to make a binary file of registered red frames
    %if db.expred, then compute mean image for green experiments with red
    %channel available while doing registration
ops0.redMeanImg             = 1; %(cell detection) if 1, will output mimgRED in ops data struc
ops0.redthres               = 1.35; %(cell detection) the higher the thres the less red cells
ops0.redmax                 = 1; %(cell detection)the higher the max the more NON-red cells

%------Finalize Settings------
db0 = db;
%db0.expred                  = db0.expts; %needed to fix weird glitch in make_db

%% --- RUN THE PIPELINE --- %% 

for iexp = 1 %[1:length(db0)]
    db = db0(iexp);
    run_pipeline(db, ops0);
    
    add_deconvolution(ops0, db);
    
    %add red channel information (if it exists)
    if isfield(db,'expred') && ~isempty(db.expred)
        %creates mean red channel image aligned to green channel
        red_expts = ismember(db.expts, getOr(db, 'expred', []));
        if ~ops0.redMeanImg || sum(red_expts)==0
            run_REDaddon_sourcery(db, ops0); 
        end
        
        % identify red cells in mean red channel image
        % fills dat.stat.redcell, dat.stat.notred, dat.stat.redprob
        identify_redcells_sourcery(db, ops0); 
        
    end
    
end
%% STRUCTURE OF RESULTS FILE 

 %----F*.mat file----% note: is amended with _proc following GUI interaction
    %Fcell: cell traces
    %FcellNeu: Neuropil traces
    %sp: deconvolved spike times and corresponding amplitudes
    %stat: structure with LOTS of outputs (SEE BELOW)

%----F*.mat File stat structure----% 
    %iscell: automated label, based on anatomy, further changed by classification in GUI
    %neuropilCoefficient: multiplicative coefficient on the neuropil signal
    %xpix, ypix: x and y indices of pixels belonging to this max. 
    %ipix: linearized indices ((ypix, xpix) --> ypix + (xpix-1) x Ly) of pixels belonging to this mask.
    %isoverlap: whether the pixels overlap with other masks.
    %lam, lambda: mask coefficients for the corresponding pixels. 
        %lambda is the same as lam, but normalized to 1.
    %med: median of y and x pixels in the ROI 
    %blockstarts: the cumulative number of frames per block. 
        %Could be useful for concatenating experiments correctly (some planes will have fewer frames/block).
    %footprint, mrs, mrs0, cmpct, aspec_ratio, , skew, std,mimgProj, maxMinusMed, top5pcMinusMed: 
        %these are used by the automated classifier to label an ROI as cell or not.
    %ellipse: general shape of ROI in coordinates
    %redratio: red pixels inside / red pixels outside
    %redcelll: redratio > mean(redratio) + redthres*std(redratio)
    %notred: redratio < mean(redratio) + redmax*std(redratio)

 %----regops*.mat file----% 
    %shows settings for registration, cell detection etc.
    %mimg: target mean image computed at the beginning of registration, frames are all aligned to this model
    %mimg1: mean image computed from all the frames across all experiments
    %DS: offsets computed in XY
