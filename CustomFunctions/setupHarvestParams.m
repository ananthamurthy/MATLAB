HOME_DIR = '/Users/ananth/Documents/';
ANALYSIS_DIR = '/Users/ananth/Desktop/Work/Analysis/';
addpath(strcat(HOME_DIR, 'MATLAB/ImagingAnalysis/Suite2P-ananth/localCopies'))
addpath(genpath(strcat(HOME_DIR, 'MATLAB/CustomFunctions'))) % my custom functions
make_db

%% Method A
job = 0;
%1
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = "A";
params(job).sdcpStart = 1;
params(job).sdcpEnd = 50;

%2
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = "A";
params(job).sdcpStart = 51;
params(job).sdcpEnd = 100;

%3
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = "A";
params(job).sdcpStart = 101;
params(job).sdcpEnd = 150;

%4
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = "A";
params(job).sdcpStart = 151;
params(job).sdcpEnd = 220;

%% B
%5
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = "B";
params(job).sdcpStart = 1;
params(job).sdcpEnd = 50;

%6
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = "B";
params(job).sdcpStart = 51;
params(job).sdcpEnd = 100;

%3-1
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = "B";
params(job).sdcpStart = 101;
params(job).sdcpEnd = 125;

%3-2
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = "B";
params(job).sdcpStart = 101;
params(job).sdcpEnd = 125;

%4
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = "B";
params(job).sdcpStart = 151;
params(job).sdcpEnd = 220;

%% C
%1
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = "A";
params(job).sdcpStart = 1;
params(job).sdcpEnd = 50;


%% D
%1
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = "A";
params(job).sdcpStart = 1;
params(job).sdcpEnd = 50;

%% E
%1
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = "A";
params(job).sdcpStart = 1;
params(job).sdcpEnd = 50;