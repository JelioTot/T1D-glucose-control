function Qvalues = UpdateQ(Qvalues, state, action, nextState, reward, alpha, gamma)

Qvalues(state, action) = Qvalues(state, action) + alpha*(reward + gamma*max(Qvalues(nextState, :)) - Qvalues(state, action));

% update the Q values
end