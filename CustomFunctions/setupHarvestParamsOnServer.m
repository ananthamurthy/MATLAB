HOME_DIR = '/home/bhalla/ananthamurthy/';
ANALYSIS_DIR = '/home/bhalla/ananthamurthy/Work/Analysis/';
addpath(strcat(HOME_DIR, 'MATLAB/ImagingAnalysis/Suite2P-ananth/localCopies'))
addpath(genpath(strcat(HOME_DIR, 'MATLAB/CustomFunctions'))) % my custom functions
make_db
%saveDirec = strcat(ANALYSIS_DIR, 'Imaging/');
saveFolder = strcat(ANALYSIS_DIR, 'Imaging/', db.mouseName, '/', db.date, '/');

%% SETUP HARVEST PARAMETERS - Method A
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

%% SETUP HARVEST PARAMETERS - Method B
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

%7-1
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = "B";
params(job).sdcpStart = 101;
params(job).sdcpEnd = 125;

%7-2
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = "B";
params(job).sdcpStart = 101;
params(job).sdcpEnd = 125;

%8
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = "B";
params(job).sdcpStart = 151;
params(job).sdcpEnd = 220;

%% SETUP HARVEST PARAMETERS - Method C
%9
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = "A";
params(job).sdcpStart = 1;
params(job).sdcpEnd = 220;


%% SETUP HARVEST PARAMETERS - Method D
%10
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = "A";
params(job).sdcpStart = 1;
params(job).sdcpEnd = 220;

%% SETUP HARVEST PARAMETERS - Method E
%11
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = "A";
params(job).sdcpStart = 1;
params(job).sdcpEnd = 50;