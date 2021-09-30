outputNames = {'Plasma Glu Conc', 'Plasma Ins Conc', 'Glu Prod', ...
    'Glu Appear Rate', 'Glu Util', 'Ins Secr'};
figure;
for i = 1:numel(outputNames)
    subplot(2, 3, i);

    [tNormal, yNormal  ]  = normalMealSim.selectbyname(outputNames{i});
    [tDiabetic, yDiabetic]  = diabeticMealSim.selectbyname(outputNames{i});
    
    plot( tNormal    , yNormal   , '-'       , ... 
          tDiabetic  , yDiabetic , '--'      );
  
    % Annotate figures 
    outputParam = sbioselect(m1, 'Name', outputNames{i});  
    title(outputNames{i});
    xlabel('time (hour)');
    if strcmp(outputParam.Type, 'parameter')
        ylabel(outputParam.ValueUnits);
    else
        ylabel(outputParam.InitialAmountUnits);
    end
    xlim([0 7]);
    
    % Add legend
    if i == 3
        legend({'Normal', 'Diabetic'}, 'Location', 'Best');
    end
    
end