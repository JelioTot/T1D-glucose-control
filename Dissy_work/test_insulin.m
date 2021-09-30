function [savedIOB] = test_insulin(Ut, time)

Kdia = 0.0195;
C1 = 0;
C2 = 0;
running = 1;
savedC1 = [];
savedC2 = [];
savedIOB = [];

for i = 1:time
DeltaC1 = Ut - Kdia*C1;
DeltaC2 = Kdia*(C1 - C2);
IOB = C1 + C2;

C1 = C1 + DeltaC1;
C2 = C2 + DeltaC2; 

savedC1 = [savedC1, C1/10];
savedC2 = [savedC2, C2/10];
savedIOB = [savedIOB, IOB/10];

end

% figure(9);
% plot(savedC1)
% hold on
% plot(savedC2)
% plot(savedIOB)
% hold off

