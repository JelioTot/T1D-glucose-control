function reward = RewardFunction(state, action, Time)

carbo = state/300;
carbs = floor(carbo);
state = state - 300*carbs;  
for i = 1:30
    if (action == i)
            if(state/10 > 8)
                reward = -(state/8)/10;
                break
            elseif (state/10 < 4)
                if (state == 1) && (action == 1)
                    reward = 0;
                    break
                end
                reward = -(4/state)*2;
                break
            else
                reward = 1;
                break
            end
        
    else
        reward = 0;
%     end
    end
end

end