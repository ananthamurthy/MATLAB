close all
clear

addpath(genpath('/Users/ananth/Documents/MATLAB/CustomFunctions')) % my custom functions
addpath(genpath('/Users/ananth/Documents/MATLAB/ImagingAnalysis')) % Additional functions
addpath(genpath('/Users/ananth/Documents/MATLAB/ImagingAnalysis/Suite2P-ananth'))

make_db
saveDirec = '/Users/ananth/Desktop/Work/Analysis/Imaging/';
saveFolder = [saveDirec db.mouseName '/' db.date '/'];

%Load processed data (processed dfbf for dataset/session)
o = load([saveFolder db.mouseName '_' db.date '.mat']);

nCells = size(o.dfbf,1);

% Signal parameters
Fs = db.samplingRate; % Sampling frequency in Hz
T = 1/Fs; % Sampling period
L = db.nFrames; % Length of signal
t = (0:L-1)*T; % Time vector

% Define frequency domain and plot the single-sided amplitude spectrum
f = Fs*(0:(L/2))/L;

for cell = 1:nCells
    
    Y = fft(squeeze(o.dfbf_2D(cell, :)));
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    
    if cell <= 20
        fig1 = figure(1);
        set(fig1,'Position',[300,300,1200,1000])
        title(sprintf('Cell: %i', cell-1))
        subplot(5, 4, cell)
        plot(f,P1)
        hold on
        %title('Single-Sided Amplitude Spectrum of X(t)')
        xlabel('f (Hz)')
        ylabel('|P1(f)|')
    elseif cell <= 40
        fig2 = figure(2);
        set(fig2,'Position',[300,300,1200,1000])
        title(sprintf('Cell: %i', cell-1))
        subplot(5, 4, cell-20)
        plot(f,P1)
        hold on
        %title('Single-Sided Amplitude Spectrum of X(t)')
        xlabel('f (Hz)')
        ylabel('|P1(f)|')
    elseif cell <= 60
        fig3 = figure(3);
        set(fig3,'Position',[300,300,1200,1000])
        title(sprintf('Cell: %i', cell-1))
        subplot(5, 4, cell-40)
        plot(f,P1)
        hold on
        %title('Single-Sided Amplitude Spectrum of X(t)')
        xlabel('f (Hz)')
        ylabel('|P1(f)|')
    elseif cell <= 80
        fig4 = figure(4);
        set(fig4,'Position',[300,300,1200,1000])
        title(sprintf('Cell: %i', cell-1))
        subplot(5, 4, cell-60)
        plot(f,P1)
        hold on
        %title('Single-Sided Amplitude Spectrum of X(t)')
        xlabel('f (Hz)')
        ylabel('|P1(f)|')
    elseif cell <= 100
        fig5 = figure(5);
        set(fig5,'Position',[300,300,1200,1000])
        title(sprintf('Cell: %i', cell-1))
        subplot(5, 4, cell-80)
        plot(f,P1)
        hold on
        %title('Single-Sided Amplitude Spectrum of X(t)')
        xlabel('f (Hz)')
        ylabel('|P1(f)|')
    elseif cell <= 120
        fig6 = figure(6);
        set(fig6,'Position',[300,300,1200,1000])
        title(sprintf('Cell: %i', cell-1))
        subplot(5, 4, cell-100)
        plot(f,P1)
        hold on
        %title('Single-Sided Amplitude Spectrum of X(t)')
        xlabel('f (Hz)')
        ylabel('|P1(f)|')
    elseif cell <= 140
        fig7 = figure(7);
        set(fig7,'Position',[300,300,1200,1000])
        title(sprintf('Cell: %i', cell-1))
        subplot(5, 4, cell-120)
        plot(f,P1)
        hold on
        %title('Single-Sided Amplitude Spectrum of X(t)')
        xlabel('f (Hz)')
        ylabel('|P1(f)|')
    end
end

for fig = 1:7
    figure(fig)
    print(['/Users/ananth/Desktop/fig' num2str(fig)], '-djpeg');
end