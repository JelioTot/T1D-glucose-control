
Time = 1440;
Top = 30*10*21;   %30 is max blood sugar level on any sensor * 10 for decimal point * 20 for carb injestion in multiples of 10 carbs
terminationState = 1440;
minVal = 0.01;
maxVal = 0.1;
actionCnt = 30;
gamma = 0.9;
alpha = 0.1;
explore = 10;
trial = 500;
final = 0;


Qvalues = InitQtable(Top, maxVal, minVal, actionCnt);
[runs, Qvalues, x, y, inRangeP] = Experiment(alpha, gamma, trial, explore,  Time, Top, final);
%[steps, Qvalues, x, y] = Trial(alpha, gamma, episodes, explore, Time , Qvalues);
disp(Qvalues)
explore =0;
breakfast = 1;
    lunch = 1;
    dinner = 1;
    final = 1;
[steps, Qvalues, x, y, inRangePercent, InsulinWhenAmount, foodTime, foodIntake] = Episode(alpha, gamma, explore, terminationState, Time, Qvalues, breakfast, lunch, dinner, final);
increaseFoods = [];
q = x;
r = y;
    
time = size(InsulinWhenAmount);
a = size(r);
for ins = 1:time(2)
    r(InsulinWhenAmount(1,ins)) = r(InsulinWhenAmount(1,ins)) + 10*InsulinWhenAmount(2,ins);
    b = a(2) - (InsulinWhenAmount(1,ins));
    for rise = 1:b
        r(InsulinWhenAmount(1,ins)+rise) = r(InsulinWhenAmount(1,ins)+rise) + 10*InsulinWhenAmount(2,ins);
    end
end
Rise = [];
figure (1);
plot(x,y/10)

figure (3);
plot(x,r/10);

amount = size(InsulinWhenAmount);
units = 1;
carbs = 10;
ratio = carbs/units;
Fall = [];
insulinDrop = [];
save('Qvalues', 'Qvalues')


for i = 1:amount(2)
    fallTime = round(rand*45 + 120);
    Fall = [Fall, fallTime];
    drop = InsulinWhenAmount(2,i)/fallTime;
    insulinDrop = [insulinDrop, drop];
end

for k = 1:amount(2)
    time = a(2) - InsulinWhenAmount(1,k);
    [savedIOB] = test_insulin(InsulinWhenAmount(2,k), time);
    for fall = 1:time
        %store = fall;
%         if InsulinWhenAmount(1,k)+(fall) > 1441
%             fall = 0;
%         end
        r(InsulinWhenAmount(1,k)+(fall)) = r(InsulinWhenAmount(1,k)+(fall)) - savedIOB(fall); %%fall*10*insulinDrop(k);
%         if fall == Fall(k)
%             b = a(2) - (InsulinWhenAmount(1,k) + Fall(k));
%             for all = 1:b
%                 r(InsulinWhenAmount(1,k)+(fall)+all) = r(InsulinWhenAmount(1,k)+(fall)+all) - fall*10*insulinDrop(k);
%             end
%             
%         end
        %fall = store;
    end
   
end


for i = 1:3
    RiseTime = round(rand*30 + 60);
    Rise = [Rise, RiseTime];
    increase = foodIntake(i)/RiseTime;
    increaseFoods = [increaseFoods, increase];
end


for p = 1:3
    normalized = foodtest(foodIntake(p));
    for rise = 1:50
        r(foodTime(p)+ rise) = r(foodTime(p)+rise) - foodIntake(p)*sum(normalized(rise:50)) ;% +    %%%(Rise(p)-rise)*increaseFoods(p);
    end

end


% % % for p = 1:3
% % %     for rise = 1:Rise(p)
% % %         r(foodTime(p)+rise) = r(foodTime(p)+rise) + rise*increaseFoods(p);
% % %         if rise == Rise(p)
% % %             a = size(r);
% % %             b = a(2) - (foodTime(p) + Rise(p));
% % %             for  all = 1:b
% % %                 r(foodTime(p)+rise+all) = r(foodTime(p)+rise+all) + rise*increaseFoods(p);
% % %             end
% % %         end
% % %     end
% % %     %r(foodTime(p)+Rise(p);
% % % end



figure(5);
plot(x,r/10);
hold on ;

plot(x,y/10);
hold off;

    inRange = y(r<80 & r>40);
    number = size(inRange);
    number = number(2);
    inRangePercent = (number/1440)*100;

 
state = 1;
disp(inRangePercent);
%simBlood(Time);


