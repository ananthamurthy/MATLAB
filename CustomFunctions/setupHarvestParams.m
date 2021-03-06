%% SETUP HARVEST PARAMETERS - Method A
job = 0;
%1
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = 'A';
params(job).sdcpStart = 1;
params(job).sdcpEnd = 52;
params(job).date = 20210227;
params(job).gRun = 1;
params(job).trim = 0;
params(job).trimRun = 0;

%2
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = 'A';
params(job).sdcpStart = 53;
params(job).sdcpEnd = 104;
params(job).date = 20210227;
params(job).gRun = 1;
params(job).trim = 0;
params(job).trimRun = 0;

%3
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = 'A';
params(job).sdcpStart = 105;
params(job).sdcpEnd = 156;
params(job).date = 20210227;
params(job).gRun = 1;
params(job).trim = 0;
params(job).trimRun = 0;

%4
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = 'A';
params(job).sdcpStart = 157;
params(job).sdcpEnd = 208;
params(job).date = 20210227;
params(job).gRun = 1;
params(job).trim = 0;
params(job).trimRun = 0;

%% SETUP HARVEST PARAMETERS - Method B
%5
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = 'B';
params(job).sdcpStart = 1;
params(job).sdcpEnd = 52;
params(job).date = 20210227;
params(job).gRun = 1;
params(job).trim = 0;
params(job).trimRun = 0;

%6
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = 'B';
params(job).sdcpStart = 53;
params(job).sdcpEnd = 104;
params(job).date = 20210227;
params(job).gRun = 1;
params(job).trim = 0;
params(job).trimRun = 0;

%7
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = 'B';
params(job).sdcpStart = 105;
params(job).sdcpEnd = 156;
params(job).date = 20210227;
params(job).gRun = 1;
params(job).trim = 0;
params(job).trimRun = 0;

%8
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = 'B';
params(job).sdcpStart = 157;
params(job).sdcpEnd = 208;
params(job).date = 20210227;
params(job).gRun = 1;
params(job).trim = 0;
params(job).trimRun = 0;

%% SETUP HARVEST PARAMETERS - Method C
% %9
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = 'C';
params(job).sdcpStart = 1;
params(job).sdcpEnd = 208;
params(job).date = 20210227;
params(job).gRun = 1;
params(job).trim = 0;
params(job).trimRun = 0;

%% SETUP HARVEST PARAMETERS - Method D
%10
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = 'D';
params(job).sdcpStart = 1;
params(job).sdcpEnd = 208;
params(job).date = 20210227;
params(job).gRun = 1;
params(job).trim = 0;
params(job).trimRun = 0;

%% SETUP HARVEST PARAMETERS - Method E
%11
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = 'E';
params(job).sdcpStart = 1;
params(job).sdcpEnd = 208;
params(job).date = 20210227;
params(job).gRun = 1;
params(job).trim = 0;
params(job).trimRun = 0;

%% SETUP HARVEST PARAMETERS - Method F
%12
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = 'F';
params(job).sdcpStart = 1;
params(job).sdcpEnd = 208;
params(job).date = 20210227;
params(job).gRun = 1;
params(job).trim = 0;
params(job).trimRun = 0;