function [action, insulin] = ActionSelection(Qvalues, state, explore, n)

insulin = 0;
prob = randi([1 100],1);            %get random integer
if (prob >= explore)                  % 90% of the time
    row = Qvalues(state, :);           %find the largest Q value in a given state numbers row and perform that action
    V = max(row);
    MaxQ= find(row == V);
    action = MaxQ;
    if explore == 0
        if action > 1
            insulin = 1;
        else 
            insulin = 0;
        end
    
    end

else
    action = randi([1 30],1);                % randomly chose an action
  
end
end
