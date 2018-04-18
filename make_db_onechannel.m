%%ONE CHANNEL RECORDINGS%%

i = 0;
%Suite2P assumes a file structure-- essentially 
    %containing folder -> mouse -> date -> area (must be numeric) -> tiff
 %mouse_name and date can be arrays to run animals against each other,
    %or compare same animal from day to day
        %i.e. {'GCaMP_mRuby_p10', 'GCaMP_mRuby_p11'}
    %expts can be a matrix to run areas against one another
        %i.e. keep same mouse name, [1 2 3], or if multiple animals 
        %{[1 2 3], [4 5 6]}
i = i+1;
db(i).mouse_name    = 'LK_020118_1_8_postDOR';
db(i).date          = '2018-02-15';
db(i).expts         = [1];
%db(i).nchannels     = 1; %number of channels in tiff
db(i).nplanes       = 1; %number of planes of the recording
db(i).diameter      = 12; %desired diameter of ROIs
db(i).zoom          = 2; %zoom of microscope


%----Extra Entries----%
% db(i).BiDiPhase        = 0; % adjust the relative phase of consecutive lines
% db(i).nSVD             = 1000; % will overwrite the default, only for this dataset
% db(i).comments         = 'very bright signal';

