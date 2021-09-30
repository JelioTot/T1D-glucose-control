function [steps, Qvalues, x, y, inRangePercent, InsulinWhenAmount, foodTime, foodIntake] = Episode(alpha, gamma, explore, terminationState, Time, Qvalues, breakfast, lunch, dinner, final)


state = round(rand*10 + 4,1)*10;
running = 1;
steps = 1;
x = [1];
y = [state];
inRangePercent = [];
extraMeal = [];
RiseTime = 0;

breakfastTime = round((rand*180))+420;  %%random breakfast
lunchTime = round((rand*120))+720;      %%random lunch
dinnerTime = round((rand*240))+1050;     %%random dinner

for more = 1:10
    extraMealTime = round(rand*1400);
    while extraMealTime == (breakfastTime||lunchTime||dinnerTime)
        extraMealTime = round(rand*1400);
    end
    extraMeal = [extraMeal, extraMealTime];
end
    

breakfastIntake = round((rand*20*10));
lunchIntake = round((rand*20*10));
dinnerIntake = round((rand*20*10));

foodTime = [breakfastTime, lunchTime, dinnerTime];
whenInsulin = [];
amountInsulin = [];



while (running == 1)
    if state > 6300
        state = 6300;
    end
    [action, insulin] = ActionSelection(Qvalues, state, explore, Time);
    [nextState, x, y] = TransitionFunction(state, action, Time, x, y, final); 
    reward = RewardFunction(nextState, action, Time);
    Qvalues = UpdateQ(Qvalues, state, action, nextState, reward, alpha, gamma);
   
    if(steps == Time)
        running = 0;
    end
    steps = steps + 1;     %step
    x = [x, steps];
    state = nextState;      %update state
    
    s = any(extraMeal(:)==steps);
    
    if final ~= 1
        if s == 1
            stepSave = steps;
            mealIntake = round((rand*20*10));
            mealCarbs = round(mealIntake/10)*10;
            statesave = state;
            stateGraph = state + mealIntake;
            state = state + mealIntake + (mealCarbs/10)*300;
        end
    end
    
    if (steps == breakfastTime && breakfast == 1)
        stepSave = steps;
        
        breakfastCarbs = round(breakfastIntake/10)*10;
        statesave = state;
%         RiseTime = round(rand*30 + 60);
%         increase = breakfastIntake/RiseTime;
        stateGraph = state + breakfastIntake;
        state = state + breakfastIntake + (breakfastCarbs/10)*300;
        %y(steps+1) = stateGraph;
    end
    if (steps == lunchTime && lunch == 1)
        stepSave = steps;
        
        lunchCarbs = round(lunchIntake/10)*10;
        stateGraph = state + lunchIntake;
        statesave = state;
%         RiseTime = round(rand*30 + 60);
%         increase = lunchIntake/RiseTime;
        state = state + lunchIntake + (lunchCarbs/10)*300;
        %y(steps+1) = stateGraph;
    end
    if (steps == dinnerTime && dinner == 1)
        stepSave = steps;
        
        statesave = state;
        dinnerCarbs = round(dinnerIntake/10)*10;
        stateGraph = state + dinnerIntake;
%         RiseTime = round(rand*30 + 60);
%         increase = lunchIntake/RiseTime;
        state = state + dinnerIntake + (dinnerCarbs/10)*300;
        %y(steps+1) = stateGraph;
    end
    foodIntake = [breakfastIntake, lunchIntake, dinnerIntake];
    if final == 1
%         if RiseTime ~= 0
%             if stepSave + RiseTime ~= steps
%                 stateGraph = statesave + increase + round((rand - 0.5)*2);
%                 statesave = stateGraph;
%                 y(steps+1) = stateGraph;
%             else
%                 RiseTime = 0;
%             end
%         end
        if insulin == 1
            whenInsulin = [whenInsulin, steps];
            amountInsulin = [amountInsulin, action-1];
            
        end
    end
end

InsulinWhenAmount = [whenInsulin; amountInsulin];
if (explore == 0)
    
    inRange = y(y<80 & y>40);
    number = size(inRange);
    number = number(2);
    inRangePercent = (number/1440)*100;
    
end


end