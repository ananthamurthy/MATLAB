% PURPOSE - Analysis code for TEC behaviour including FEC and Motion
% DEPENDENCIES - First sort all trials as .mat files using sortingVideos.m

%clear all
%close all

addpath('/Users/ananth/Documents/MATLAB/CustomFunctions')

%Operations
saveData = 0;
plotHistogram = 0;
playVideo = 1;

crop = [120 55 50 30]; %[xmin ymin width height]
m = 5; %for median filter
level = 0.45; %for binarization

if playVideo == 1
    nTrials = 60;
    startTrial = 9;
    startFrame = 1;
    
    %Video details
    samplingRate = 100; % in Frames Per Second (FPS)
    trialDuration = 2; % in seconds
    nFrames = 80;
    %nFrames = samplingRate*trialDuration; %per trial
end

%Dataset details
mouseName = 'M5';
sessionType = 9;
session = 5;

saveDirec = '/Users/ananth/Desktop/Work/Analysis/VideoAnalysis/';
direc = '/Users/ananth/Desktop/Work/Analysis/VideoAnalysis/Videos/';

dataset = ['Mouse' mouseName '_SessionType' num2str(sessionType) '_Session' num2str(session)];
disp(['Working on ' dataset])

fontSize = 12;

if playVideo == 1
    disp('Playing Video ...');
    for trial = startTrial:nTrials
        %Load the reference image (first image in Trial 1)
        raw = load([direc 'Mouse' mouseName '/' dataset, ...
            '/' dataset '_Trial' num2str(trial)]);
        for frame = startFrame:nFrames
            refImage = rgb2gray(raw.raw(:,:,:,frame));
            
            %Equalize histogram
            refImage_histeq = histeq(refImage);
            
            %Median filter
            refImage_medfilt = medfilt2(refImage_histeq,[m m]);
            
            %Crop image
            croppedImage = imcrop(refImage_medfilt,crop);
            
            %Binarize
            croppedImage_binary = im2bw(croppedImage,level);
            %croppedImage_binary = imbinarize(croppedImage);
            
            figure(2)
            pause(0.1)
            subplot(1,2,1)
            imagesc(croppedImage)
            colormap(hot)
            z = colorbar;
            ylabel(z,'Intensity (A.U.)', ...
                'FontSize', fontSize,...
                'FontWeight', 'bold')
            title(['Cropped Image ' mouseName ...
                ' ST' num2str(sessionType) ' S' num2str(session) ...
                ' Trial ' num2str(trial)], ...
                'FontSize', fontSize, ...
                'FontWeight', 'bold')
            
            subplot(1,2,2)
            imagesc(croppedImage_binary)
            colormap(hot)
            z = colorbar;
            ylabel(z,'Intensity (A.U.)', ...
                'FontSize', fontSize,...
                'FontWeight', 'bold')
            title(['Binarized Frame ' num2str(frame)], ...
                'FontSize', fontSize, ...
                'FontWeight', 'bold')
        end
    end
else
    %Load the reference image (first image in Trial 1)
    raw = load([direc 'Mouse' mouseName '/' dataset '/' dataset '_Trial1']);
    refImage = rgb2gray(raw.raw(:,:,:,1));
    figure(1)
    subplot(1,3,1)
    imagesc(refImage)
    z = colorbar;
    ylabel(z,'Intensity (A.U.)', ...
        'FontSize', fontSize,...
        'FontWeight', 'bold')
    title(['Reference Image - ' mouseName, ...
        ' ST' num2str(sessionType) ' S' num2str(session)], ...
        'FontSize', fontSize, ...
        'FontWeight', 'bold')
    
    %Equalize histogram
    refImage_histeq = histeq(refImage);
    subplot(1,3,2)
    imagesc(refImage_histeq)
    z = colorbar;
    ylabel(z,'Intensity (A.U.)', ...
        'FontSize', fontSize,...
        'FontWeight', 'bold')
    title('Histogram Equalized', ...
        'FontSize', fontSize, ...
        'FontWeight', 'bold')
    
    %Median filter
    refImage_medfilt = medfilt2(refImage_histeq,[m m]);
    subplot(1,3,3)
    imagesc(refImage_medfilt)
    colormap(hot)
    z = colorbar;
    ylabel(z,'Intensity (A.U.)', ...
        'FontSize', fontSize, ...
        'FontWeight', 'bold')
    title('Median Filtered', ...
        'FontSize', fontSize, ...
        'FontWeight', 'bold')
    
    %Crop image
    %rectCrop = [100 35 50 30]; %[xmin ymin width height]
    crop = [120 55 50 30]; %[xmin ymin width height]
    croppedImage = imcrop(refImage_medfilt,crop);
    
    %Binarize
    croppedImage_binary = im2bw(croppedImage,level);
    %croppedImage_binary = imbinarize(croppedImage);
    
    figure(2)
    subplot(1,2,1)
    imagesc(croppedImage)
    colormap(hot)
    z = colorbar;
    ylabel(z,'Intensity (A.U.)', ...
        'FontSize', fontSize,...
        'FontWeight', 'bold')
    title(['Cropped Image - ' mouseName, ...
        ' ST' num2str(sessionType) ' S' num2str(session)], ...
        'FontSize', fontSize, ...
        'FontWeight', 'bold')
    
    subplot(1,2,2)
    imagesc(croppedImage_binary)
    colormap(hot)
    z = colorbar;
    ylabel(z,'Intensity (A.U.)', ...
        'FontSize', fontSize,...
        'FontWeight', 'bold')
    title('Binarized', ...
        'FontSize', fontSize, ...
        'FontWeight', 'bold')
    
    if plotHistogram == 1
        hist_crop = imhist(croppedImage);
        hist_crop_medfilt = imhist(refImage_medfilt);
        figure(3)
        subplot(1,2,1)
        plot(hist_crop)
        title(['Histogram (Cropped Image) - ' mouseName ' ST' num2str(sessionType) ' S' num2str(session)])
        xlabel('Value', ...
            'FontSize', fontSize, ...
            'FontWeight', 'bold')
        ylabel('Counts', ...
            'FontSize', fontSize, ...
            'FontWeight', 'bold')
        subplot(1,2,2)
        plot(hist_crop_medfilt)
        %axis([0 60 0 500])
        title('Median Filtered')
        xlabel('Value', ...
            'FontSize', fontSize, ...
            'FontWeight', 'bold')
        ylabel(' Counts', ...
            'FontSize', fontSize, ...
            'FontWeight', 'bold')
    end
end
disp('All done!')