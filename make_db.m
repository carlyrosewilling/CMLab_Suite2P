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
db(i).mouse_name            = 'GCaMP_mRuby_p12'; %Mouse name
db(i).date                  = '2018-04-18'; %date or age of mouse
db(i).expts                 = [1]; %area
db(i).nchannels             = 2; %number of channels in tiff
db(i).nchannels_red         = 2; %how many channels red block had(assumes red is last)
db(i).nplanes               = 1; %number of planes of the recording
db(i).ichannel              = 1; %1 if green is first, 2 if red is first
db(i).expred                = db(i).expts;
db(i).readTiffHeader        = 0;
db(i).gchannel              = 1; %number of green channels
db(i).AlignToRedChannel     = 1; %1 if you want to register to Red channel
db(i).diameter              = 12; %desired diameter of ROIs
db(i).zoom                  = 2; %zoom of microscope


%----Extra Entries----%
db(i).BiDiPhase           = 0; % adjust the relative phase of consecutive lines
% db(i).nSVD                = 1000; % will overwrite the default, only for this dataset
% db(i).comments            = 'very bright signal';

