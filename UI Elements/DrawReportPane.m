%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DrawReportPane: This function creates 2 result parameters.
% The function builds these as children to a passed UIPanel object.
% A different function must be used to update these objects
%
% Author: Rylee Mattingly
% Version: 0.0.1
% Creation Date: 12.2.2020
%
%-------------------------------------------------------------------------%
% PassedPanel
%   +--ReportGrid
%      +--LeftMetric
%         +--LeftLabel1
%         +--LeftLabel2
%      +--MiddleMetric
%         +--MiddleLabel1
%         +--MiddleLabel2
%      +--RightMetric
%         +--RightLabel1
%         +--RightLabel2
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function DrawReportPane(PassedPanel)

    ReportGrid = uigridlayout(PassedPanel, [1 3]);
    ReportGrid.ColumnWidth = {'2x', '2x', '1x'};

    LeftMetric = uigridlayout(ReportGrid, [1 2]);
   
    LeftLabel1 = uilabel(LeftMetric);
    LeftLabel1.Text = 'Noisy Mean Squared Error:';
    LeftLabel1.HorizontalAlignment = 'Right';
    LeftLabel1.FontWeight = 'bold';
    LeftLabel1.FontSize = 14;
    
    LeftLabel2 = uilabel(LeftMetric);
    LeftLabel2.Text = '---';
    LeftLabel2.FontWeight = 'bold';
    LeftLabel2.FontSize = 14;
    
    MiddleMetric = uigridlayout(ReportGrid, [1 2]);
    
    MiddleLabel1 = uilabel(MiddleMetric);
    MiddleLabel1.Text = "Filtered Mean Squared Error:";
    MiddleLabel1.HorizontalAlignment = 'right';
    MiddleLabel1.FontWeight = 'bold';
    MiddleLabel1.FontSize = 14;
    
    MiddleLabel2 = uilabel(MiddleMetric);
    MiddleLabel2.Text = '---';
    MiddleLabel2.FontWeight= 'bold';
    MiddleLabel2.FontSize = 14;
    
    RightMetric = uigridlayout(ReportGrid, [1 2]);
    
    RightLabel1 = uilabel(RightMetric);
    RightLabel1.Text = "Output SNR:";
    RightLabel1.HorizontalAlignment = 'Right';
    RightLabel1.FontWeight = 'bold';
    RightLabel1.FontSize = 14;
    
    RightLabel2 = uilabel(RightMetric);
    RightLabel2.Text = '---';
    RightLabel2.FontWeight = 'bold';
    RightLabel2.FontSize = 14;
end