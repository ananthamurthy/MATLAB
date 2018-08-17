% AUTHOR - Kambadur Ananthamurthy
% PURPOSE - FEC analysis
% DEPENDENCIES - Find the image processing parameters using findTheEye.m
%              - mseb.m (for plotting shaded error bars; open-source)

tic
clear
%close all
addpath(genpath('/Users/ananth/Documents/MATLAB/CustomFunctions'))

%% Operations (0 == Don't Perform; 1 == Perform)
saveData = 0;
doFECAnalysis = 0;
smoothenStimuli = 0;
alignFrames = 0; %Turn off if saved data is already aligned.
plotFigures = 1;
playVideo = 0;

%% Dataset details
mice = [26];
sessionType = 5;
nSessions = 1;
nTrials = 60; %default is 60
startSession = nSessions; %single sessions
%startSession = 1;
startTrial = 1;
startFrame = 1;

% Video details
nFrames = 313;
% if sessionType == 6
%     nFrames = 330; %per trial;
% elseif sessionType == 8
%     nFrames = 370; %per trial;
% else
%     nFrames = 330;
% end

%% Directories
imageProcessDirec = '/Users/ananth/Desktop/Work/Analysis/Behaviour/ImageProcess/';
rawDirec = '/Users/ananth/Desktop/Work/Behaviour/DATA/';
%rawDirec = '/Volumes/ananthamurthy/EyeBlinkBehaviour/';
motionDirec = '/Users/ananth/Desktop/Work/Analysis/Behaviour/Motion/';
performanceDirec = '/Users/ananth/Desktop/Work/Analysis/Behaviour/Performance/';
saveDirec = '/Users/ananth/Desktop/Work/Analysis/Behaviour/FEC/';
if ~exist(rawDirec, 'dir')
    warning('Raw directory not found')
    return
end

%% Plotting aesthetics
fontSize = 16;
lineWidth = 2;
markerWidth = 7;
transparency = 0.5;

%%
for mouse = 1:length(mice)
    mouseName = ['M' num2str(mice(mouse))];
    %mouseName = ['G5-' num2str(mice(mouse))];
    
    for session = startSession:nSessions
        dataset = [mouseName '_' num2str(sessionType) '_' num2str(session)];
        disp(['Working on ' dataset])
        
        if doFECAnalysis == 1
            disp('Performing FEC analysis ...')
            
            % Load image processing parameters
            load([imageProcessDirec mouseName '/' dataset '/imageProcess.mat'])
            
            % Preallocation - for every individual session
            eyeClosure = nan(nTrials,nFrames);
            eyeClosure_baseline = nan(nTrials,1);
            fec = nan(nTrials,nFrames);
            probeTrials = zeros(nTrials,1); %NOTE: Don't initialize with "NaN".
            timestamp3 = zeros(nTrials,nFrames);
            trialCount = zeros(nTrials,nFrames);
            puffUS = zeros(nTrials,nFrames);
            toneCS = zeros(nTrials,nFrames);
            ledCS = zeros(nTrials,nFrames);
            motion1 = zeros(nTrials,nFrames);  %--xxxx [should be removed]
            motion2 = zeros(nTrials,nFrames);  %--xxxx [should be removed]
            camera = zeros(nTrials,nFrames);
            microscope = zeros(nTrials,nFrames);
            speed = zeros(nTrials,nFrames);
            direction = zeros(nTrials,nFrames);
            
            % Analyze every trial for FEC
            for trial = startTrial:nTrials
                disp(['Trial ' num2str(trial) '/' num2str(nTrials)])
                
                if trial <10
                    file = [rawDirec mouseName '/' dataset, ...
                        '/trial_00' num2str(trial) '.tif'];
                else
                    file = [rawDirec mouseName '/' dataset, ...
                        '/trial_0' num2str(trial) '.tif'];
                    
                    if (mod(trial,10) == 0) && trial ~= nTrials
                        disp(['... working on ' dataset ' ...'])
                    end
                end
                
                for frame = startFrame:nFrames
                    %1 - Load the reference image (first image in Trial 1)
                    try
                        refImage = double(imread(file, frame));
                    catch
                        warning(['Unable to find Frame: ' num2str(frame)])
                        continue
                    end
                    
                    %2 - Crop image - for eye (absolute coordinates)
                    croppedImage = imcrop(refImage,crop);
                    
                    %3 - Crop again - for FEC (relative coordinates)
                    fecImage = imcrop(croppedImage,fecROI);
                    
                    %4 - Binarize
                    %fecImage_vector = reshape(fecImage,1,[]);
                    %threshold = prctile(fecImage_vector,70);
                    % Use the same "threshold"used by "findTheEye.m"
                    binImage = fecImage > threshold; %binarize
                    
                    binImage_vector = reshape(binImage,1,[]);
                    eyeClosure(trial,frame) = (length(find(~binImage)))/length(binImage_vector);
                    
                    % Read Datalines from each frame
                    dataLine = char(refImage(1,:));
                    %disp(dataLine)
                    commai = strfind(dataLine,',');
                    
                    if length(commai)<6 %There will be at least 6 commas the dataLine is complete
                        %warning(['Frame ' num2str(frame) ' has no data line'])
                        continue
                    else
                        %{
                        DATALINE:
                        1. msg_ (timestamp1)
                        2. "%lu,%d,%d,%d,%d,%d,%d,%d,%d,%s" (timestamp2)
                        3. timestamp3 (arduino)
                        4. trial_count_
                        5. puff
                        6. tone
                        7. led,
                        8. motion1    --xxxx [should be removed]
                        9. motion2    --xxxx [should be removed]
                        10. camera
                        11. microscope
                        12. trial_state_
                        13. timestamp4 (usb mouse for treadmill tracking)
                        14. timestamp5
                        15. speed (10x normalized)
                        16. direction
                        17. Dilawar's measure of eye-blinks
                        %}
                        timestamp3(trial,frame) = str2double(sprintf(dataLine(commai(2)+1:commai(3)-1),'%s'));
                        trialCount(trial,frame) = str2double(sprintf(dataLine(commai(3)+1:commai(4)-1),'%s'));
                        if trialCount(trial,frame) ~= trial
                            warning('trialCount ~= trial')
                        end
                        puffUS(trial,frame)= str2double(sprintf(dataLine(commai(4)+1:commai(5)-1),'%s'));
                        %tone(trial,frame) = str2double(sprintf(dataLine(commai(5)+1:commai(6)-1),'%s'));
                        ledCS(trial,frame) = str2double(sprintf(dataLine(commai(6)+1:commai(7)-1),'%s'));
                        %motion1(trial,frame) = str2double(sprintf(dataLine(commai(7)+1:commai(8)-1),'%s'));
                        %motion2(trial,frame) = str2double(sprintf(dataLine(commai(8)+1:commai(9)-1),'%s'));
                        camera(trial,frame) = str2double(sprintf(dataLine(commai(9)+1:commai(10)-1),'%s'));
                        microscope(trial,frame) = str2double(sprintf(dataLine(commai(10)+1:commai(11)-1),'%s'));
                        %speed(trial,frame) = str2double(sprintf(dataLine(commai(14)+1:commai(15)-1),'%s'));
                        %direction(trial,frame) = str2double(sprintf(dataLine(commai(15)+1:end),'%s'));
                    end
                    
                    if playVideo == 1
                        if frame == startFrame
                            disp('Playing Video ...');
                        end
                        pause(0.05)
                        fig2 = figure(2);
                        set(fig2,'Position', [100, 100, 600, 450]);
                        subplot(1,3,1)
                        imagesc(croppedImage)
                        colormap(gray)
                        z = colorbar;
                        ylabel(z,'Intensity (A.U.)', ...
                            'FontSize', fontSize, ...
                            'FontWeight', 'bold')
                        title(['Eye - ' mouseName ...
                            ' ST' num2str(sessionType) ' S' num2str(session) ...
                            ' Trial ' num2str(trial) ...
                            ' Frame ' num2str(frame)], ...
                            'FontSize', fontSize, ...
                            'FontWeight', 'bold')
                        
                        subplot(1,3,2)
                        imagesc(fecImage)
                        colormap(gray)
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
                    
                    %close(2)
                end
                
                eyeClosure_baseline(trial) = max(eyeClosure(trial,:));
                fec(trial,:) = 1 - (eyeClosure(trial,:)/eyeClosure_baseline(trial));
                
                % Probe Trials
                puffi = find(puffUS(trial,:));
                if isempty(puffi)
                    probeTrials(trial,1) = 1;
                    disp('Probe trial found!')
                end
                
                disp('... done')
            end
        else
            load([saveDirec mouseName '/' dataset '/fec.mat']);
            %load([motionDirec mouseName '/' dataset '/motion.mat']);
            %load([performanceDirec mouseName '/' dataset '/performance.mat']);
            fec = FEC;
            ledCS = LED;
            puffUS = PUFF;
            motion1 = MOTION1;
            motion2 = MOTION2;
        end
        
        if smoothenStimuli == 1
            disp('Smoothening stimuli ...')
            %Smoothen (on account of missing data lines)
            %LED
            for trial = startTrial:nTrials
                ledi = find(ledCS(trial,:));
                if isempty(ledi)
                    warning(['There is no CS played in trial ' num2str(trial)])
                    continue
                else
                    ledCS(trial,ledi(1):ledi(end)) = 1;
                end
                
                %Puff
                puffi = find(puffUS(trial,:));
                if isempty(puffi)
                    warning(['There is no US played in trial ' num2str(trial)])
                    continue
                else
                    puffUS(trial,puffi(1):puffi(end)) = 1;
                end
            end
            disp('... smoothening complete!')
        end
        
        if alignFrames == 1
            disp('Aligning frames ...')
            csStartFrame = nan(nTrials,1);
            csStartOffset = nan(nTrials,1);
            %usStartFrame = nan(nTrials,1);
            %nISIFrames = nan(nTrials,1);
            
            %Aligned matrices
            alignedFEC = nan(nTrials,(nFrames-10)); % -5 on each end
            alignedPuff = nan(nTrials,(nFrames-10)); % -5 on each end
            alignedLED = nan(nTrials,(nFrames-10)); % -5 on each end
            alignedMotion1 = nan(nTrials,(nFrames-10)); % -5 on each end
            alignedMotion2 = nan(nTrials,(nFrames-10)); % -5 on each end
            alignedSpeed = nan(nTrials,(nFrames-10)); % -5 on each end
            alignedDirection = nan(nTrials,(nFrames-10)); % -5 on each end
            
            for trial = 1:nTrials
                csStartFrame(trial) = find(ledCS(trial,:),1);
                csStartOffset(trial) = csStartFrame(trial) - 101; %assuming ~200 fps (CS starts at 500 ms)
                if abs(csStartOffset(trial)) > 4
                    disp(['The CS Start Offset for Trial ' num2str(trial) ' is > 5'])
                    disp('Please consider skippping ...')
                    %fec
                    alignedFEC(trial,:) = fec(trial,(5:(end-6)));
                    %puff
                    alignedPuff(trial,:) = puffUS(trial,(5:(end-6)));
                    %led
                    alignedLED(trial,:) = ledCS(trial,(5:(end-6)));
                    %motion1
                    alignedMotion1(trial,:) = motion1(trial,(5:(end-6)));
                    %motion2
                    alignedMotion1(trial,:) = motion2(trial,(5:(end-6)));
                    %speed
                    alignedSpeed(trial,:) = speed(trial,(5:(end-6)));
                    %direction
                    alignedDirection(trial,:) = direction(trial,(5:(end-6)));
                else
                    %fec
                    alignedFEC(trial,:) = fec(trial,(5+csStartOffset(trial)):((end-6)+csStartOffset(trial)));
                    %puff
                    alignedPuff(trial,:) = puffUS(trial,(5+csStartOffset(trial)):((end-6)+csStartOffset(trial)));
                    %led
                    alignedLED(trial,:) = ledCS(trial,(5+csStartOffset(trial)):((end-6)+csStartOffset(trial)));
                    %motion1
                    alignedMotion1(trial,:) = motion1(trial,(5+csStartOffset(trial)):((end-6)+csStartOffset(trial)));
                    %motion2
                    alignedMotion1(trial,:) = motion2(trial,(5+csStartOffset(trial)):((end-6)+csStartOffset(trial)));
                    %speed
                    alignedSpeed(trial,:) = speed(trial,(5+csStartOffset(trial)):((end-6)+csStartOffset(trial)));
                    %direction
                    alignedDirection(trial,:) = direction(trial,(5+csStartOffset(trial)):((end-6)+csStartOffset(trial)));
                end
            end
            FEC = alignedFEC;
            PUFF = alignedPuff;
            LED = alignedLED;
            MOTION1 = alignedMotion1;
            MOTION2 = alignedMotion2;
            SPEED = alignedSpeed;
            DIRECTION = alignedDirection;
            disp('... frame alignment complete!')
        else
            FEC = fec;
            PUFF = puffUS;
            LED = ledCS;
            %            MOTION1 = motion1;
            %            MOTION2 = motion2;
            %            SPEED = speed;
            %            DIRECTION = direction;
        end
        
        if saveData == 1
            saveFolder = [saveDirec mouseName '/' dataset '/'];
            if ~isdir(saveFolder)
                mkdir(saveFolder);
            end
            
            % Save FEC curve
            save([saveFolder 'fec.mat' ], ...
                'eyeClosure', 'FEC', ...
                'LED', 'PUFF', ...
                'MOTION1', 'MOTION2', ...
                'probeTrials',...
                'camera', 'microscope', ...
                'SPEED', 'DIRECTION',...
                'crop', 'fecROI')
        end
        
        if plotFigures == 1
            % FEC plots
            fig4 = figure(4);
            set(fig4,'Position', [100, 100, 1200, 500]);
            clf
            %subplot(6,9,1:45)
            %subFig1 = subplot(3,2,1);
            subFig1 = subplot(2,2,1);
            imagesc(FEC)
            caxis([0 1])
            colormap(subFig1, jet)
            %freezeColors
            if sessionType == 6
                title([mouseName ' S' num2str(session) ' | 550 ms Trace | FEC '], ...
                    'FontSize', fontSize, ...
                    'FontWeight', 'bold')
            elseif sessionType == 8
                title([mouseName ' S' num2str(session) ' | 750 ms Trace | FEC '], ...
                    'FontSize', fontSize, ...
                    'FontWeight', 'bold')
            elseif sessionType == 3
                title([mouseName ' S' num2str(session) ' | 500 ms Trace | FEC '], ...
                    'FontSize', fontSize, ...
                    'FontWeight', 'bold')
            elseif sessionType == 4
                title([mouseName ' S' num2str(session) ' | CS-Only | FEC'], ...
                    'FontSize', fontSize, ...
                    'FontWeight', 'bold')
            elseif sessionType == 5
                title([mouseName ' S' num2str(session) ' | 450 ms Trace | FEC '], ...
                    'FontSize', fontSize, ...
                    'FontWeight', 'bold')
            else
                title([ mouseName ' S' num2str(session) ' | "?" | FEC'], ...
                    'FontSize', fontSize, ...
                    'FontWeight', 'bold')
            end
            set(gca,'XTick', [35, 75, 115, 155, 195, 235]) %NOTE: Starting 5 frames are skipped
            set(gca,'XTickLabel', ({200; 400; 600; 800; 1000; 1200})) %NOTE: At 200 fps, every frame is a 5 ms timestep.
            xlabel('Time/ms', ...
                'FontSize', fontSize,...
                'FontWeight', 'bold')
            set(gca,'YTick',[10, 20, 30, 40, 50, 60])
            set(gca,'YTickLabel',({10; 20; 30; 40; 50; 60}))
            ylabel('Trials', ...
                'FontSize', fontSize,...
                'FontWeight', 'bold')
            z = colorbar;
            %cbfreeze(z)
            set(z,'YTick',[0, 1])
            set(z,'YTickLabel',({'Open', 'Closed'}))
            set(gca,'FontSize', fontSize-2)
            
            % Probe Trials
            %subFig2 = subplot(3,2,2);
            subFig2 = subplot(2,2,2);
            imagesc(probeTrials)
            caxis([0 1])
            colormap(subFig2, gray)
            %freezeColors
            title('Probe Trials', ...
                'FontSize', fontSize, ...
                'FontWeight', 'bold')
            set(gca,'XTick', [])
            set(gca,'XTickLabel', [])
            ylabel('Trials', ...
                'FontSize', fontSize,...
                'FontWeight', 'bold')
            z = colorbar;
            %cbfreeze(z)
            set(z,'YTick',[0, 1])
            set(z,'YTickLabel',({'No'; 'Yes'}))
            set(gca,'FontSize', fontSize-2)
            
            % Stimuli
            %subFig3 = subplot(3,2,3);
            subFig3 = subplot(2,2,3);
            stimuli = (1*LED)+(2*PUFF);
            imagesc(stimuli)
            caxis([0 2])
            colormap(subFig2, cool)
            %freezeColors
            title('Stimuli', ...
                'FontSize', fontSize, ...
                'FontWeight', 'bold')
            set(gca,'XTick', [35, 75, 115, 155, 195, 235]) %NOTE: Starting 5 frames are skipped
            set(gca,'XTickLabel', ({200; 400; 600; 800; 1000; 1200})) %NOTE: At 200 fps, every frame is a 5 ms timestep.
            xlabel('Time/ms', ...
                'FontSize', fontSize,...
                'FontWeight', 'bold')
            set(gca,'YTick',[10, 20, 30, 40, 50, 60])
            set(gca,'YTickLabel',({10; 20; 30; 40; 50; 60}))
            ylabel('Trials', ...
                'FontSize', fontSize,...
                'FontWeight', 'bold')
            z = colorbar;
            %cbfreeze(z)
            set(z,'YTick',[0, 1, 2])
            set(z,'YTickLabel',({'Off'; 'LED'; 'Puff'}))
            set(gca,'FontSize', fontSize-2)
            
            % Shaded error bars
            notProbes = find(~probeTrials);
            meanFEC = nanmean(FEC(notProbes,:),1);
            meanFEC_stddev = nanstd(FEC(notProbes,:),1);
            probes = find(probeTrials);
            meanFEC_probe = nanmean(FEC(probes,:),1);
            meanFEC_probe_stddev = nanstd(FEC(probes,:),1);
            
            %subFig4 = subplot(3,2,4);
            subFig4 = subplot(2,2,4);
            lineProps1.col{1} = 'red';
            lineProps2.col{1} = 'green';
            mseb([],meanFEC, meanFEC_stddev,...
                lineProps1, transparency);
            hold on
            mseb([],meanFEC_probe, meanFEC_probe_stddev,...
                lineProps2, transparency);
            ylim([0 1]);
            title('CS+US vs Probe Trials', ...
                'FontSize', fontSize, ...
                'FontWeight', 'bold')
            set(gca,'XTick', [35, 75, 115, 155, 195, 235]) %NOTE: Starting 5 frames are skipped
            set(gca,'XTickLabel', ({200; 400; 600; 800; 1000; 1200})) %NOTE: At 200 fps, every frame is a 5 ms timestep.
            xlabel('Time/ms', ...
                'FontSize', fontSize,...
                'FontWeight', 'bold')
            ylabel('FEC', ...
                'FontSize', fontSize, ...
                'FontWeight', 'bold')
            set(gca,'FontSize', fontSize-2)
            legend('mean Paired +/- stddev', 'mean Probe +/- stddev','Location', 'northwest')
            
            %             % Motion
            %             subFig2 = subplot(3,2,5);
            %             MOTION = SPEED.*DIRECTION;
            %             imagesc(MOTION)
            %             caxis([0 2])
            %             colormap(subFig2, jet)
            %             %freezeColors
            %             title('Motion', ...
            %                 'FontSize', fontSize, ...
            %                 'FontWeight', 'bold')
            %             set(gca,'XTick', [35, 75, 115, 155, 195, 235]) %NOTE: Starting 5 frames are skipped
            %             set(gca,'XTickLabel', ({200; 400; 600; 800; 1000; 1200})) %NOTE: At 200 fps, every frame is a 5 ms timestep.
            %             xlabel('Time/ms', ...
            %                 'FontSize', fontSize,...
            %                 'FontWeight', 'bold')
            %             set(gca,'YTick',[10, 20, 30, 40, 50, 60])
            %             set(gca,'YTickLabel',({10; 20; 30; 40; 50; 60}))
            %             ylabel('Trials', ...
            %                 'FontSize', fontSize,...
            %                 'FontWeight', 'bold')
            %             z = colorbar;
            %             %cbfreeze(z)
            %             %set(z,'YTick',[0, 1, 2])
            %             %set(z,'YTickLabel',({'Off'; 'LED'; 'Puff'}))
            %             set(gca,'FontSize', fontSize-2)
            %
            %             % Shaded error bars
            %             notProbes = find(~probeTrials);
            %             meanFEC = nanmean(FEC(notProbes,:),1);
            %             meanFEC_stddev = nanstd(FEC(notProbes,:),1);
            %             probes = find(probeTrials);
            %             meanFEC_probe = nanmean(FEC(probes,:),1);
            %             meanFEC_probe_stddev = nanstd(FEC(probes,:),1);
            %
            %             subplot(3,2,6)
            %             lineProps1.col{1} = 'red';
            %             lineProps2.col{1} = 'green';
            %             mseb([],meanFEC, meanFEC_stddev,...
            %                 lineProps1, transparency);
            %             hold on
            %             mseb([],meanFEC_probe, meanFEC_probe_stddev,...
            %                 lineProps2, transparency);
            %             ylim([0 1]);
            %             title('CS+US vs Probe Trials', ...
            %                 'FontSize', fontSize, ...
            %                 'FontWeight', 'bold')
            %             set(gca,'XTick', [35, 75, 115, 155, 195, 235]) %NOTE: Starting 5 frames are skipped
            %             set(gca,'XTickLabel', ({200; 400; 600; 800; 1000; 1200})) %NOTE: At 200 fps, every frame is a 5 ms timestep.
            %             xlabel('Time/ms', ...
            %                 'FontSize', fontSize,...
            %                 'FontWeight', 'bold')
            %             ylabel('FEC', ...
            %                 'FontSize', fontSize, ...
            %                 'FontWeight', 'bold')
            %             set(gca,'FontSize', fontSize-2)
            %             legend('mean Paired +/- stddev', 'mean Probe +/- stddev','Location', 'northwest')
            
            print(['/Users/ananth/Desktop/figs/FEC/fec_' ...
                mouseName '_' num2str(sessionType) '_' num2str(session)],...
                '-djpeg');
        end
        disp([dataset ' analyzed'])
    end
end
toc
beep
disp('All done!')