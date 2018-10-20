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

%Please edit the following for the dataset to be analysed
dataset = 'M26_5_1-ROI';
%NOTE: the dataset directory - dataDirec/dataset/dataset
%All trials should be concatenated using Fiji and saved as dataset.tif

dataDirec = '/Users/ananth/Desktop/Work/Imaging/';
outputdir = '/Users/ananth/Desktop/Work/Analysis/Imaging/cellSortOutput/';

%Checks to see if directories are available
if ~isfolder(dataDirec)
    disp('Data directory not found')
end

if ~isfolder(outputdir)
    disp('Output directory not found')
end

%Parameters -
nPCs = 400;
mu = 0.6; %Check Mukamel et al., 2009 for details; try the range 0.1 to 0.2
%nIC = length(PCuse); %PCuse is generated during code run
%nIC = nPCs;
%f0 = movm; %movm is generated during code run
mode = 'series';
dt = 0.069;
%ICuse = 1:nIC; %nIC is generated during code run
smwidth = 0.5;
thresh = 2.5;
arealims = 100;
plotting = 1;
subtractmean = 1;
%leave the following empty
flims = [];
dsamp = [];
badframes = [];
ica_A_guess = [];
termtol = [];
maxrounds = [];
tlims = [];
ratebin = [];
plottype = [];
% deconvtau = 0;
% spike_thresh = 2;
% normalization = 1;

if isfolder(dataDirec)
    formatSpec = [dataDirec, '%s/%s.tif'];
    fn = sprintf(formatSpec, dataset, dataset);
    
    %Step1: PCA
    % Input Parameters - PCA:
    % Discription - file:///Users/ananth/Documents/MATLAB/ImagingAnalysis/CellSort/doc/CellsortPCA.html
    [mixedsig, mixedfilters, CovEvals, covtrace, movm, movtm] = CellsortPCA(fn, flims, nPCs, dsamp, outputdir, badframes);
    
    %Step2a: Choose PCs
    fig1 = figure(1);
    set(fig1,'Position', [1100, 1100, 600, 450]);
    [PCuse] = CellsortChoosePCs(fn, mixedfilters);
    
    %Step2b: Plot PC spctrum
    CellsortPlotPCspectrum(fn, CovEvals, PCuse)
    
    %Step3a: ICA
    nIC = length(PCuse);
    % Discription - file:///Users/ananth/Documents/MATLAB/ImagingAnalysis/CellSort/doc/CellsortICA.html
    [ica_sig, ica_filters, ica_A, numiter] = CellsortICA(mixedsig, mixedfilters, CovEvals, PCuse, mu, nIC, ica_A_guess, termtol, maxrounds);
    
    %Step3b: Plot ICA
    f0 = movm;
    ICuse = 1:nIC;
    fig2 = figure(2);
    set(fig2,'Position', [500, 100, 1200, 800]);
    %CellsortICAplot(mode, ica_filters, ica_sig, f0, tlims, dt, ratebin, plottype, ICuse, spt, spc)
    CellsortICAplot(mode, ica_filters, ica_sig, f0, tlims, dt, ratebin, plottype, ICuse)
    
    %Step4a: Segmentation
    [ica_segments, segmentlabel, segcentroid] = CellsortSegmentation(ica_filters, smwidth, thresh, arealims, plotting);
    
    %Step4b: Apply filter
    cell_sig = CellsortApplyFilter(fn, ica_segments, flims, movm, subtractmean);
    
    %Step5: Find spikes
    %[spmat, spt, spc] = CellsortFindspikes(ica_sig, thresh, dt, deconvtau, normalization);
    
    %Show results
    figure(2)
    %set(fig2,'Position', [500, 100, 600, 450]);
    CellsortICAplot(mode, ica_filters, ica_sig, f0, tlims, dt, ratebin, plottype, ICuse)
    
end