% PURPOSE - To establish the best parameters to find the eye
% DEPENDENCIES - None.
% NOTE - sortingVideos.m is now obsolete

clear
%close all

addpath(genpath('/Users/ananth/Documents/MATLAB/CustomFunctions'))

%% Directories
imageProcessDirec = '/Users/ananth/Desktop/Work/Analysis/Behaviour/ImageProcess/';

%% Operations
saveData = 1;
loadData = 0;
playVideo = 0;

%% Dataset details
mice = 30;
sessionType = 'An2';
nSessions = 4;

nTrials = 1; %default is 1
startSession = nSessions;
startTrial = nTrials;
startFrame = 1;

%Video details
%samplingRate = 100; % in Frames Per Second (FPS)
%trialDuration = 1.5; % in seconds
%nFrames = floor(samplingRate*trialDuration); %per trial
nFrames = 281; % 207
% if sessionType == 6
%     nFrames = 330; %per trial;
% elseif sessionType == 8
%     nFrames = 370; %per trial;
% else
%     nFrames = 330;
% end

%% Directories
saveDirec = '/Users/ananth/Desktop/Work/Analysis/Behaviour/ImageProcess/';
rawDirec = '/Users/ananth/Desktop/Work/Behaviour/DATA/';
%rawDirec = '/Volumes/ananthamurthy/EyeBlinkBehaviour/';

if ~exist(rawDirec, 'dir')
    warning('Raw directory not found')
    return
end

%% Plotting aesthetics
fontSize = 16;

%%
for mouse = 1:length(mice)
    
    mouseName = ['M' num2str(mice(mouse))];
    %mouseName = ['G5-' num2str(mice(mouse))];
    %mouseName = ['G' num2str(mice(mouse))];
    
    for session = startSession:nSessions
        %         dataset = ['Mouse' mouseName '_SessionType' num2str(sessionType) '_Session' num2str(session)];
        dataset = [mouseName '_' num2str(sessionType) '_' num2str(session)];
        disp(['Working on ' dataset])
        
        %%
        if loadData == 0
            percentile = 45;
            % Crop parameters - please change to requirement
            xmin1 = 280;
            ymin1 = 90;
            width1 = 200;
            height1 = 150;
            crop = [xmin1 ymin1 width1 height1]; %[xmin ymin width height] of refImage
            
            % !!! - Please Don't Change! - !!!
            % FEC parameters - please don't change, unless absolutely necessary
            xmin2 = 118; % Don't change
            ymin2 = 5; % Don't change
            width2 = 30; % Don't change
            height2 = 150;% Don't change; currently set to height1.
            fecROI = [xmin2 ymin2 width2 height2]; %[xmin ymin width height] of croppedImage
        else
            load([imageProcessDirec mouseName '/' dataset '/imageProcess.mat'])
        end
        
        
        if playVideo == 1
            disp('Playing Video ...');
            for trial = startTrial:nTrials
                if trial <10
                    file = [rawDirec mouseName '/' dataset, ...
                        '/00' num2str(trial) '.tiff'];
                else
                    file = [rawDirec mouseName '/' dataset, ...
                        '/0' num2str(trial) '.tiff'];
                end
                
                %for frame = startFrame:nFrames
                for frame = 80:300 %default -> 80:200
                    %1 - Load the reference image (first image in Trial 1)
                    refImage = double(imread(file, frame));
                    
                    %2 - Crop image - for eye (absolute coordinates)
                    croppedImage = imcrop(refImage,crop);
                    
                    %3 - Crop again - for FEC (relative coordinates)
                    fecImage = imcrop(croppedImage,fecROI);
                    
                    %4 - Binarize
                    %if frame == startFrame
                    if frame == 80
                        fecImage_vector = reshape(fecImage,1,[]);
                        threshold = prctile(fecImage_vector,percentile);
                    end
                    binImage = fecImage > threshold; %binarize
                    
                    pause(0.1)
                    fig2 = figure(2);
                    set(fig2,'Position', [50, 50, 1000, 400]);
                    subplot(1,3,1)
                    imagesc(croppedImage)
                    %colormap(gray)
                    z = colorbar;
                    ylabel(z,'Intensity (A.U.)', ...
                        'FontSize', fontSize,...
                        'FontWeight', 'bold')
                    title(['Eye - ' mouseName ...
                        ' ST' num2str(sessionType) ' S' num2str(session) ...
                        ' Trial ' num2str(trial) ...
                        ' Frame ' num2str(frame)], ...
                        'FontSize', fontSize, ...
                        'FontWeight', 'bold')
                    
                    subplot(1,3,2)
                    imagesc(fecImage)
                    %colormap(gray)
                    z = colorbar;
                    ylabel(z,'Intensity (A.U.)', ...
                        'FontSize', fontSize, ...
                        'FontWeight', 'bold')
                    title(['Binarized Frame ' num2str(frame)], ...
                        'FontSize', fontSize, ...
                        'FontWeight', 'bold')
                    
                    subplot(1,3,3)
                    imagesc(binImage)
                    colormap(gray)
                    z = colorbar;
                    ylabel(z,'Intensity (A.U.)', ...
                        'FontSize', fontSize, ...
                        'FontWeight', 'bold')
                    title(['fecROI Frame ' num2str(frame)], ...
                        'FontSize', fontSize, ...
                        'FontWeight', 'bold')
                end
            end
        else
            %1 - Load the reference image (typically first image in Trial 1)
            file = [rawDirec mouseName '/' dataset '/00' num2str(startTrial) '.tiff'];
            refImage = double(imread(file, 1));
            
            %2 - Crop image - for eye (absolute coordinates)
            croppedImage = imcrop(refImage,crop);
            
            %3 - Crop again - for FEC (relative coordinates)
            fecImage = imcrop(croppedImage,fecROI);
            
            %4 - Binarize
            %threshold = prctile(reshape(fecImage,[((height2+1)*(width2+1)),1]),50);
            fecImage_vector = reshape(fecImage,1,[]);
            threshold = prctile(fecImage_vector,percentile);
            binImage = fecImage > threshold; %binarize
            
            fig1 = figure(1);
            set(fig1,'Position', [50, 50, 600, 400]);
            subplot(2,2,1)
            imagesc(refImage)
            z = colorbar;
            ylabel(z,'Intensity (A.U.)', ...
                'FontSize', fontSize,...
                'FontWeight', 'bold')
            title('1. Original', ...
                'FontSize', fontSize, ...
                'FontWeight', 'bold')
            set(gca,'FontSize',fontSize)
            
            subplot(2,2,2)
            imagesc(croppedImage)
            z = colorbar;
            ylabel(z,'Intensity (A.U.)', ...
                'FontSize', fontSize,...
                'FontWeight', 'bold')
            title('2. Cropped', ...
                'FontSize', fontSize, ...
                'FontWeight', 'bold')
            set(gca,'FontSize',fontSize)
            
            subplot(2,2,3)
            imagesc(fecImage)
            colormap(gray)
            z = colorbar;
            ylabel(z,'Intensity (A.U.)', ...
                'FontSize', fontSize, ...
                'FontWeight', 'bold')
            title('3. FEC ROI', ...
                'FontSize', fontSize, ...
                'FontWeight', 'bold')
            set(gca,'FontSize',fontSize)
            
            subplot(2,2,4)
            imagesc(binImage);
            colormap(gray)
            z = colorbar;
            ylabel(z,'Intensity (A.U.)', ...
                'FontSize', fontSize, ...
                'FontWeight', 'bold')
            title('4. Binarized', ...
                'FontSize', fontSize, ...
                'FontWeight', 'bold')
            set(gca,'FontSize',fontSize)
            
        end
        
        if saveData == 1
            saveFolder = [saveDirec mouseName '/' dataset '/'];
            if ~isdir(saveFolder)
                mkdir(saveFolder);
            end
            %Save FEC curve
            save([saveFolder 'imageProcess.mat' ], ...
                'crop', 'fecROI', 'threshold')
        end
    end
end
disp('All done!')