Code adapted from BME Senior Project Design Project
Automated Two-Photon Imaging Analysis (ATPIA)
Eric Tam, Sherry Yan, William Yen (2017)

Version 4.0: Last edited February 14, 2017 by WWY
Code has been tested for Matlab R2016a and later

***This version is for using with Suite2P data***


For SINGLE analysis:

Run 'singleAnalysis.m' in Matlab and follow on screen prompts.
Stats files will be saved as a .mat file ([videoname]_stats.mat) in the same folder as
the video chosen.


For BATCH analysis

Run 'batchAnalysis.m' in Matlab and follow on screen prompts
Stats files will be saved as a .mat file ([videoname]_stats.mat) in the same folder as
the video chosen.
To retreive stats, run 'retreiveStats.m'. All stats will be imported into the structure named 
'Filelist'. Stats will be in the field 'stats'

**************************************************************************

Edited on March 27, 2018 by WWY

Revisions:
    1) Comment all Scripts
    2) Add in error checks and redundancies
    3) Turn suite2P_convert.m into a function
    4) Replace section in batchAnalysis.m with suite2P_convert()
    5) Add error logging into batchAnalysis.m
    6) Change save directory to base directory>stats