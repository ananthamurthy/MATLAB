%TITLE - Custom code to use the CellSort toolbox
%AUTHOR - Kambadur Ananthmurthy
%PROJECT STARTED on 14th Aug, 2018

% PCA Inputs:
%   fn - movie file name. Must be in TIFF format.
%   flims - 2-element vector specifying the endpoints of the range of
%   frames to be analyzed. If empty, default is to analyze all movie
%   frames.
%   nPCs - number of principal components to be returned
%   dsamp - optional downsampling factor. If scalar, specifies temporal
%   downsampling factor. If two-element vector, entries specify temporal
%   and spatial downsampling, respectively.
%   outputdir - directory in which to store output .mat files
%   badframes - optional list of indices of movie frames to be excluded
%   from analysis

% PCA Outputs:
%   mixedsig - N x T matrix of N temporal signal mixtures sampled at T
%   points.
%   mixedfilters - N x X x Y array of N spatial signal mixtures sampled at
%   X x Y spatial points.
%   CovEvals - largest eigenvalues of the covariance matrix
%   covtrace - trace of covariance matrix, corresponding to the sum of all
%   eigenvalues (not just the largest few)
%   movm - average of all movie time frames at each pixel
%   movtm - average of all movie pixels at each time frame, after
%   normalizing each pixel deltaF/F


% ICA Inputs:
%   mixedsig - N x T matrix of N temporal signal mixtures sampled at T
%   points.
%   mixedfilters - N x X x Y array of N spatial signal mixtures sampled at
%   X x Y spatial points.
%   CovEvals - eigenvalues of the covariance matrix
%   PCuse - vector of indices of the components to be included. If empty,
%   use all the components
%   mu - parameter (between 0 and 1) specifying weight of temporal
%   information in spatio-temporal ICA
%   nIC - number of ICs to derive
%   termtol - termination tolerance; fractional change in output at which
%   to end iteration of the fixed point algorithm.
%   maxrounds - maximum number of rounds of iterations

% ICA Outputs:
%   ica_sig - nIC x T matrix of ICA temporal signals
%   ica_filters - nIC x X x Y array of ICA spatial filters
%   ica_A - nIC x N orthogonal unmixing matrix to convert the input to output signals
%   numiter - number of rounds of iteration before termination

close all
%clear all
clear

addpath(genpath('/Users/ananth/Documents/MATLAB/ImagingAnalysis/CellSort'))

dataDir = '/Users/ananth/Desktop/Work/Imaging/';
outputdir = '/Users/ananth/Desktop/Work/Analysis/Imaging/cellSortOutput/';

%Checks to see if directories are available
if ~isfolder(dataDir)
    disp('Data directory not found')
end

if ~isfolder(outputdir)
    disp('Output directory not found')
end

%Please edit the following for the dataset to be analysed
date = '20180508';
dataset = 'M26_5_1-ROI';
nTrials = 1; %default: 60
startTrial = 1;
%startTrial = nTrials;

% Input Parameters - PCA:
% Discription - file:///Users/ananth/Documents/MATLAB/ImagingAnalysis/CellSort/doc/CellsortPCA.html
flims = []; %leave empty
nPCs = 245; %value optimized after trial run
dsamp = [];
badframes = [];

% Input Parameters - ICA:
% Discription - file:///Users/ananth/Documents/MATLAB/ImagingAnalysis/CellSort/doc/CellsortICA.html
PCuse = [];
mu = 0.1; %Check Mukamel et al., 2009 for details
nIC = [];
termtol = [];
maxrounds = [];

if isfolder(dataDir)
    formatSpec = [dataDir, '%s/%s/Trial%s-ROI-1.tif'];
    for trial = startTrial:nTrials
        fn = sprintf(formatSpec, date, dataset, num2str(trial));
        
        %PCA
        [mixedsig, mixedfilters, CovEvals, covtrace, movm, movtm] = CellsortPCA(fn, flims, nPCs, dsamp, outputdir, badframes);
        %Choose PCs
        
        %ICA
        [ica_sig, ica_filters, ica_A, numiter] = CellsortICA(mixedsig, mixedfilters, PCuse, mu, nIC, ica_A_guess, termtol, maxrounds);
    end
end