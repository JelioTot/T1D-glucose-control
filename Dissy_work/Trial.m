function  [steps, Qvalues, x, y,inRange] = Trial(alpha, gamma, episodes, explore, Time , Qvalues, final)
             
terminationState = 1440;
inRange = [];
inRangePercent = [];
for tidx = 1:episodes                  %loop 1000 times
% run an episode and record steps
    %disp(sprintf('Eps %d/%d', tidx, episodes));
    breakfast = 1;
    lunch = 1;
    dinner = 1;
    if tidx == episodes
        explore = 0;
    end
        [steps, Qvalues, x, y, inRangePercent, InsulinWhenAmount, foodTime, foodIntake] = Episode(alpha, gamma, explore, terminationState, Time, Qvalues, breakfast, lunch, dinner, final);
        if explore == 0 
            inRange = [inRange, inRangePercent];
        end
end
%disp(Qvalues)
end