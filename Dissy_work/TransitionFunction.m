function [nextState, x, y, yGraph] = TransitionFunction(state, action, Time, x, y, final)
    
    units = 1;
    carbs = 10;
    ratio = carbs/units;

    nextState = [];  

    for i = 1:30
        if action == i
            if state > 300
                stateNumber = state/300;
                state = state - 300*(floor(stateNumber));
            end
            nextState = state + round((rand - 0.5)*2) - ratio*(i-1);
            if nextState <= 0
                nextState = 1;
            end
        end
    end
    if isempty(nextState) == 1
        nextState = 1;
    end
        y = [y, nextState];
    if final == 1
        
   
    end
end
%end
