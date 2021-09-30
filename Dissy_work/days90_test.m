load('QvaluesHighExplore.mat', 'Qvalues')
Time = 1440;
Top = 30*10*21;   %30 is max blood sugar level on any sensor * 10 for decimal point * 20 for carb injestion in multiples of 10 carbs
terminationState = 1440;
minVal = 0.01;
maxVal = 0.1;
actionCnt = 30;
gamma = 0.9;
alpha = 0.1;
explore = 0;
trial = 500;
final = 1;
breakfast = 1;
lunch = 1;
dinner = 1;
range = [];
 Hba1c = [];

for HbA1c = 1:90



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
%figure (1);
%plot(x,y/10)

%figure (3);
%plot(x,r/10);

amount = size(InsulinWhenAmount);
units = 1;
carbs = 10;
ratio = carbs/units;
Fall = [];
insulinDrop = [];


for i = 1:amount(2)
    fallTime = round(rand*45 + 120);
    Fall = [Fall, fallTime];
    drop = InsulinWhenAmount(2,i)/fallTime;
    insulinDrop = [insulinDrop, drop];
end

delay = 100000;
for k = 1:amount(2)
    time = a(2) - InsulinWhenAmount(1,k);
    [savedIOB] = test_insulin(InsulinWhenAmount(2,k), 1441);
    for fall = 1:time
        if InsulinWhenAmount(1,k)>delay
            r(InsulinWhenAmount(1,k)+(fall)-delay) = r(InsulinWhenAmount(1,k)+(fall)-delay) - savedIOB(fall);
            if fall == time
                for p = 1:delay
                r(InsulinWhenAmount(1,k)+(fall)-delay+p) = r(InsulinWhenAmount(1,k)+(fall)-delay+p) - savedIOB(fall+p);
                end
%             for p = 1:delay
%                 r(InsulinWhenAmount(1,k)+(fall)-delay+p) = r(InsulinWhenAmount(1,k)+(fall)-delay+p) - savedIOB(fall+p);
             end    
        else
            r(InsulinWhenAmount(1,k)+(fall)) = r(InsulinWhenAmount(1,k)+(fall)) - savedIOB(fall);
        end
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

figure(5);
plot(x,r/10);

 inRange = r(r<80 & r>40);
 number = size(inRange);
 number = number(2);
 inRangePercent = (number/1440)*100;
 average = sum(r/10)/1441;
 Hba1c = [Hba1c, average];
 range = [range, inRangePercent];
 disp(inRangePercent);
 

end
Hba1cAverage = sum(Hba1c)/90;
disp(Hba1cAverage)



