

function simBlood(Time)
x = [];
y = [];
newValy = rand*10 + 4;
    for i =  1:Time 
        newValx = i;
        newValy = newValy + (rand - 0.5)*0.2;
        x = [x, newValx];
        y = [y, newValy];
    end
    plot(x,y)
end
