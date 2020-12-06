%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DrawPlotPanels: This function creates 4 axis objects with default title
% values. The function builds these as children to a passed UIPanel object.
% Time, Freq, and Plot1-4 are optional parameters.
% A different function must be used to add plots to the graph.
%
% Author: Rylee Mattingly
% Version: 0.0.1
% Creation Date: 12.2.2020
%
%-------------------------------------------------------------------------%
% PassedPanel
%   +--PlotGrid
%      +--AxisPanel1
%         +--Axis1
%      +--AxisPanel2
%         +--Axis2
%      +--AxisPanel3
%         +--Axis3
%      +--AxisPanel4
%         +--Axis4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function DrawPlotAxis (PassedPanel)

    %Create the plot grid.
    PlotGrid = uigridlayout(PassedPanel, [2 2]);
    
    %Create the 4 children of the plot grid with proper formatting.
    AxisPanel1 = uipanel(PlotGrid);
    AxisPanel1.BorderType = 'none';
    Axis1 = axes(AxisPanel1);
    Axis1.FontSize = 12;
    Axis1.FontWeight = 'bold';
    title(Axis1, 'Noisy Input X(t) vs. Reconstructed Output Y(t)');
    legend(Axis1);
    
    AxisPanel2 = uipanel(PlotGrid);
    AxisPanel2.BorderType = 'none';
    Axis2 = axes(AxisPanel2);
    Axis2.FontSize = 12;
    Axis2.FontWeight = 'bold';
    title(Axis2, 'Clean Signal vs. Reconstructed Output Y(t)');
    legend(Axis2);
    
    AxisPanel3 = uipanel(PlotGrid);
    AxisPanel3.BorderType = 'none';
    Axis3 = axes(AxisPanel3);
    Axis3.FontSize = 12;
    Axis3.FontWeight = 'bold';
    title(Axis3, 'Noisy Input X(\omega) vs. Reconstructed Output Y(\omega)');
    legend(Axis3);
    
    AxisPanel4 = uipanel(PlotGrid);
    AxisPanel4.BorderType = 'none';
    Axis4 = axes(AxisPanel4);
    Axis4.FontSize = 12;
    Axis4.FontWeight = 'bold';
    title(Axis4, 'Clean Signal vs. Reconstructed Output Y(\omega)');
    legend(Axis4);

end
