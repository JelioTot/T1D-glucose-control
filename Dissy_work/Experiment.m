function [runs, Qvalues, x, y, inRangeP] = Experiment(alpha, gamma, trial, explore,  Time, Top, final)

episodes=500;                 %number of episode to run
trialCnt=1000;                  %number of trials to run
minVal = 0.01;
maxVal = 0.1;
actionCnt = 30;
Qvalues = InitQtable(Top, maxVal, minVal, actionCnt);
inRangeP = [];


for trial = 1:trialCnt
   
disp(sprintf('trial %d/%d', trial, trialCnt));   
[runs(:,trial), Qvalues, x, y, inRange] = Trial(alpha, gamma, episodes, explore, Time , Qvalues, final);    %run trial
inRangeP = [inRangeP, inRange];
end
figure (2)
plot(inRangeP);
% M = mean(runs,2);         %calculate mean number of runs each episode took
% stdSteps = std(runs, 0, 2);      %calculate the standard deviation of the runs
% 
% figure (6)
% title('10583182: Q learning in operation across multiple trials')
% xlabel('Episode number');
% ylabel('Number of steps');                                                    %plot Q learning graph
% plot(1:episodes, M);
% errorbar(1:episodes, M, stdSteps);
end