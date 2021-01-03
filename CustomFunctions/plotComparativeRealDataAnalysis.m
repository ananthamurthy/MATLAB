normalize = 0;

figureDetails = compileFigureDetails(20, 2, 10, 0.5, 'jet'); %(fontSize, lineWidth, markerSize, transparency, colorMap)

fig1 = figure(1);
set(fig1,'Position',[200,200,1600, 800])

if normalize == 1
    %day1
    for count = 1:6
        subplot(3, 6, count)
        x = cData(1).methodF.mFOutput_batch(1).normQ1;
        if count == 1
            y = cData(1).methodA.mAOutput_batch(1).normQ;
            scatter(x, y, 'b');
            ylabel('Method A - DayA', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 2
            y = cData(1).methodB.mBOutput_batch(1).normQ;
            scatter(x, y, 'g');
            ylabel('Method B - DayA', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 3
            y = cData(1).methodC.mCOutput_batch(1).normQ1;
            scatter(x, y, 'r');
            ylabel('Method C1 - DayA', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 4
            y = cData(1).methodC.mCOutput_batch(1).normQ2;
            scatter(x, y, 'm');
            ylabel('Method C2 - DayA', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 5
            y = cData(1).methodD.mDOutput_batch(1).normQ;
            scatter(x, y, 'y');
            ylabel('Method D - DayA', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 6
            y = cData(1).methodF.mFOutput_batch(1).normQ2;
            scatter(x, y, 'k');
            ylabel('Method F1-DayA', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        else
        end
        xlabel('Method F2 - DayA', ...
            'FontSize', figureDetails.fontSize, ...
            'FontWeight', 'bold')
        set(gca,'FontSize', figureDetails.fontSize-3)
    end
    clear x
    clear y
    
    %day2
    for count = 1:6
        subplot(3, 6, 6+count)
        x = cData(2).methodF.mFOutput_batch(2).normQ1;
        if count == 1
            y = cData(2).methodA.mAOutput_batch(2).normQ;
            scatter(x, y, 'b');
            ylabel('Method A - DayB', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 2
            y = cData(2).methodB.mBOutput_batch(2).normQ;
            scatter(x, y, 'g');
            ylabel('Method B - DayB', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 3
            y = cData(2).methodC.mCOutput_batch(2).normQ1;
            scatter(x, y, 'r');
            ylabel('Method C1 - DayB', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 4
            y = cData(2).methodC.mCOutput_batch(2).normQ2;
            scatter(x, y, 'm');
            ylabel('Method C2 - DayB', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 5
            y = cData(2).methodD.mDOutput_batch(2).normQ;
            scatter(x, y, 'y');
            ylabel('Method D - DayB', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 6
            y = cData(2).methodF.mFOutput_batch(2).normQ2;
            scatter(x, y, 'k');
            ylabel('Method F2 - DayB', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        else
        end
        xlabel('Method F1 - DayB', ...
            'FontSize', figureDetails.fontSize, ...
            'FontWeight', 'bold')
        set(gca,'FontSize', figureDetails.fontSize-3)
    end
    clear x
    clear y
    
    %day1 vs day2
    for count = 1:6
        subplot(3, 6, 12+count)
        x = cData(1).methodF.mFOutput_batch(1).normQ1;
        if count == 1
            y = cData(2).methodA.mAOutput_batch(2).normQ;
            scatter(x, y, 'b');
            ylabel('Method A - DayB', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 2
            y = cData(2).methodB.mBOutput_batch(2).normQ;
            scatter(x, y, 'g');
            ylabel('Method B - DayB', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 3
            y = cData(2).methodC.mCOutput_batch(2).normQ1;
            scatter(x, y, 'r');
            ylabel('Method C1 - DayB', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 4
            y = cData(2).methodC.mCOutput_batch(2).normQ2;
            scatter(x, y, 'm');
            ylabel('Method C2 - DayB', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 5
            y = cData(2).methodD.mDOutput_batch(2).normQ;
            scatter(x, y, 'y');
            ylabel('Method D - DayB', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 6
            y = cData(2).methodF.mFOutput_batch(2).normQ2;
            scatter(x, y, 'k');
            ylabel('Method F2 - DayB', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        else
        end
        xlabel('Method F1 - DayA', ...
            'FontSize', figureDetails.fontSize, ...
            'FontWeight', 'bold')
        set(gca,'FontSize', figureDetails.fontSize-3)
    end
    clear x
    clear y
else
    %day1
    for count = 1:6
        subplot(3, 6, count)
        x = cData(1).methodF.mFOutput_batch(1).Q1;
        if count == 1
            y = cData(1).methodA.mAOutput_batch(1).Q;
            scatter(x, y, 'b');
            ylabel('Method A - DayA', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 2
            y = cData(1).methodB.mBOutput_batch(1).Q;
            scatter(x, y, 'g');
            ylabel('Method B - DayA', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 3
            y = cData(1).methodC.mCOutput_batch(1).Q1;
            scatter(x, y, 'r');
            ylabel('Method C1 - DayA', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 4
            y = cData(1).methodC.mCOutput_batch(1).Q2;
            scatter(x, y, 'm');
            ylabel('Method C2 - DayA', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 5
            y = cData(1).methodD.mDOutput_batch(1).Q;
            scatter(x, y, 'y');
            ylabel('Method D - DayA', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 6
            y = cData(1).methodF.mFOutput_batch(1).Q2;
            scatter(x, y, 'k');
            ylabel('Method F1-DayA', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        else
        end
        xlabel('Method F2 - DayA', ...
            'FontSize', figureDetails.fontSize, ...
            'FontWeight', 'bold')
        set(gca,'FontSize', figureDetails.fontSize-3)
    end
    clear x
    clear y
    
    %day2
    for count = 1:6
        subplot(3, 6, 6+count)
        x = cData(2).methodF.mFOutput_batch(2).Q1;
        if count == 1
            y = cData(2).methodA.mAOutput_batch(2).Q;
            scatter(x, y, 'b');
            ylabel('Method A - DayB', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 2
            y = cData(2).methodB.mBOutput_batch(2).Q;
            scatter(x, y, 'g');
            ylabel('Method B - DayB', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 3
            y = cData(2).methodC.mCOutput_batch(2).Q1;
            scatter(x, y, 'r');
            ylabel('Method C1 - DayB', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 4
            y = cData(2).methodC.mCOutput_batch(2).Q2;
            scatter(x, y, 'm');
            ylabel('Method C2 - DayB', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 5
            y = cData(2).methodD.mDOutput_batch(2).Q;
            scatter(x, y, 'y');
            ylabel('Method D - DayB', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 6
            y = cData(2).methodF.mFOutput_batch(2).Q2;
            scatter(x, y, 'k');
            ylabel('Method F2 - DayB', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        else
        end
        xlabel('Method F1 - DayB', ...
            'FontSize', figureDetails.fontSize, ...
            'FontWeight', 'bold')
        set(gca,'FontSize', figureDetails.fontSize-3)
    end
    clear x
    clear y
    
    %day1 vs day2
    for count = 1:6
        subplot(3, 6, 12+count)
        x = cData(1).methodF.mFOutput_batch(1).Q1;
        if count == 1
            y = cData(2).methodA.mAOutput_batch(2).Q;
            scatter(x, y, 'b');
            ylabel('Method A - DayB', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 2
            y = cData(2).methodB.mBOutput_batch(2).Q;
            scatter(x, y, 'g');
            ylabel('Method B - DayB', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 3
            y = cData(2).methodC.mCOutput_batch(2).Q1;
            scatter(x, y, 'r');
            ylabel('Method C1 - DayB', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 4
            y = cData(2).methodC.mCOutput_batch(2).Q2;
            scatter(x, y, 'm');
            ylabel('Method C2 - DayB', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 5
            y = cData(2).methodD.mDOutput_batch(2).Q;
            scatter(x, y, 'y');
            ylabel('Method D - DayB', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        elseif count == 6
            y = cData(2).methodF.mFOutput_batch(2).Q2;
            scatter(x, y, 'k');
            ylabel('Method F2 - DayB', ...
                'FontSize', figureDetails.fontSize, ...
                'FontWeight', 'bold')
        else
        end
        xlabel('Method F1 - DayA', ...
            'FontSize', figureDetails.fontSize, ...
            'FontWeight', 'bold')
        set(gca,'FontSize', figureDetails.fontSize-3)
    end
    clear x
    clear y
end
