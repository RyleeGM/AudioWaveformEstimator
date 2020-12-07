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
%      +--LinearLabel   +--LNoisyMSE   +--LFiltMSE   +--LDMSE   +--LSNRout
%      +--KalmanLabel   +--KNoisyMSE   +--KFiltMSE   +--KDMSE   +--KSNRout
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function DrawReportPane(PassedPanel)

    ReportGrid = uigridlayout(PassedPanel, [2 5]);
    ReportGrid.ColumnWidth = {'1x', '2x', '2x', '2x', '1x'};

    LinearLabel = uilabel(ReportGrid);
    LinearLabel.Text = 'Linear:';
    LinearLabel.HorizontalAlignment = 'center';
    LinearLabel.FontWeight = 'bold';
    LinearLabel.FontSize = 15;
    
    LNoisyMSE = uilabel(ReportGrid);
    LNoisyMSE.Text = 'Noisy Mean Squared Error: ---';
    LNoisyMSE.HorizontalAlignment = 'center';
    LNoisyMSE.FontWeight = 'bold';
    LNoisyMSE.FontSize = 14;
    
    LFiltMSE = uilabel(ReportGrid);
    LFiltMSE.Text = 'Filtered Mean Squared Error: ---';
    LFiltMSE.HorizontalAlignment = 'center';
    LFiltMSE.FontWeight = 'bold';
    LFiltMSE.FontSize = 14;
    
    LDMSE = uilabel(ReportGrid);
    LDMSE.Text = 'MSE Difference: ---';
    LDMSE.HorizontalAlignment = 'center';
    LDMSE.FontWeight = 'bold';
    LDMSE.FontSize = 14;
    
    LSNRout = uilabel(ReportGrid);
    LSNRout.Text = 'MSE Difference: ---';
    LSNRout.HorizontalAlignment = 'center';
    LSNRout.FontWeight = 'bold';
    LSNRout.FontSize = 14;
    
    KalmanLabel = uilabel(ReportGrid);
    KalmanLabel.Text = 'Kalman:';
    KalmanLabel.HorizontalAlignment = 'center';
    KalmanLabel.FontWeight = 'bold';
    KalmanLabel.FontSize = 15;
    
    KNoisyMSE = uilabel(ReportGrid);
    KNoisyMSE.Text = 'Noisy Mean Squared Error: ---';
    KNoisyMSE.HorizontalAlignment = 'center';
    KNoisyMSE.FontWeight = 'bold';
    KNoisyMSE.FontSize = 14;
    
    KFiltMSE = uilabel(ReportGrid);
    KFiltMSE.Text = 'Filtered Mean Squared Error: ---';
    KFiltMSE.HorizontalAlignment = 'center';
    KFiltMSE.FontWeight = 'bold';
    KFiltMSE.FontSize = 14;
    
    KDMSE = uilabel(ReportGrid);
    KDMSE.Text = 'MSE Difference: ---';
    KDMSE.HorizontalAlignment = 'center';
    KDMSE.FontWeight = 'bold';
    KDMSE.FontSize = 15;
    
    KSNRout = uilabel(ReportGrid);
    KSNRout.Text = 'MSE Difference: ---';
    KSNRout.HorizontalAlignment = 'center';
    KSNRout.FontWeight = 'bold';
    KSNRout.FontSize = 15;
end