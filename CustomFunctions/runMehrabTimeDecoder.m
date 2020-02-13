function runMehrabTimeDecoder(learned_only)
%condition to use only animals that learned the task
    if learned_only == 1 %operation
        if learned == 0 %data dependent
            %continue
        elseif learned == 1
            
        end
    elseif learned_only == 0 %opeartion: analyses all trials
    elseif learned_only == 2
        if learned == 1
            %continue
        elseif learned == 0
        end
    elseif learned_only == 4            %used to make a list of learners
        if learned == 1
            learned_listi = [learned_listi; dir_counter]; %appears to be unusued for single session runs
        else
        end
        %continue
    end

end