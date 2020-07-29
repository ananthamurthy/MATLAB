%% SETUP HARVEST PARAMETERS - Method A
job = 0;
%1
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = 'A';
params(job).sdcpStart = 1;
params(job).sdcpEnd = 50;
params(job).date = 20200729;
params(job).gRun = 1;
params(job).trim = 0;
params(job).trimRun = 0;

%2
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = 'A';
params(job).sdcpStart = 51;
params(job).sdcpEnd = 100;
params(job).date = 20200729;
params(job).gRun = 1;
params(job).trim = 0;
params(job).trimRun = 0;

%3
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = 'A';
params(job).sdcpStart = 101;
params(job).sdcpEnd = 150;
params(job).date = 20200729;
params(job).gRun = 1;
params(job).trim = 0;
params(job).trimRun = 0;

%4
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = 'A';
params(job).sdcpStart = 151;
params(job).sdcpEnd = 220;
params(job).date = 20200729;
params(job).gRun = 1;
params(job).trim = 0;
params(job).trimRun = 0;

%% SETUP HARVEST PARAMETERS - Method B
%5
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = 'B';
params(job).sdcpStart = 1;
params(job).sdcpEnd = 50;
params(job).date = 20200729;
params(job).gRun = 1;
params(job).trim = 1;
params(job).trimRun = 3;

%6
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = 'B';
params(job).sdcpStart = 51;
params(job).sdcpEnd = 100;
params(job).date = 20200729;
params(job).gRun = 1;
params(job).trim = 1;
params(job).trimRun = 3;

%7-1
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = 'B';
params(job).sdcpStart = 101;
params(job).sdcpEnd = 125;
params(job).date = 20200729;
params(job).gRun = 1;
params(job).trim = 1;
params(job).trimRun = 3;

%7-2
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = 'B';
params(job).sdcpStart = 126;
params(job).sdcpEnd = 150;
params(job).date = 20200729;
params(job).gRun = 1;
params(job).trim = 1;
params(job).trimRun = 3;

%8
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = 'B';
params(job).sdcpStart = 151;
params(job).sdcpEnd = 220;
params(job).date = 20200729;
params(job).gRun = 1;
params(job).trim = 1;
params(job).trimRun = 3;

%% SETUP HARVEST PARAMETERS - Method C
% %9
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = 'C';
params(job).sdcpStart = 1;
params(job).sdcpEnd = 220;
params(job).date = 20200729;
params(job).gRun = 1;
params(job).trim = 0;
params(job).trimRun = 0;

%% SETUP HARVEST PARAMETERS - Method D
%10
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = 'D';
params(job).sdcpStart = 1;
params(job).sdcpEnd = 220;
params(job).date = 20200729;
params(job).gRun = 1;
params(job).trim = 0;
params(job).trimRun = 0;

%% SETUP HARVEST PARAMETERS - Method E
%11
job = job + 1;
params(job).fileLocation = sprintf('%s/Imaging/%s/%s/', ANALYSIS_DIR, db.mouseName, db.date);
params(job).methodList = 'E';
params(job).sdcpStart = 1;
params(job).sdcpEnd = 220;
params(job).date = 20200729;
params(job).gRun = 1;
params(job).trim = 0;
params(job).trimRun = 0;