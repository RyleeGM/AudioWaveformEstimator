%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DrawEstSelPane: This function creates 2 buttons to select.
% The function builds these as children to a passed UIPanel object.
% A different function must be used to update these objects
%
% Author: Rylee Mattingly
% Version: 0.0.1
% Creation Date: 12.3.2020
%
%-------------------------------------------------------------------------%
% PassedPanel
%   +--SelectGrid
%      +--TitleLabel
%      +--ButtonGroup
%         +--LinearRadio
%         +--KalmanRadio
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function DrawEstSelPane(PassedPanel)

    SelectGrid = uigridlayout(PassedPanel, [2, 1]);
    SelectGrid.RowHeight = {'0.75x', '3x'};
    
    TitleLabel = uilabel(SelectGrid);
    TitleLabel.Text = 'Estimator Selector';
    TitleLabel.HorizontalAlignment = 'center';
    TitleLabel.VerticalAlignment = 'top';
    TitleLabel.FontSize = 15;
    TitleLabel.FontWeight = 'bold';

    ButtonGroup = uibuttongroup(SelectGrid);
    ButtonGroup.BorderType = 'none';
    ButtonGroup.SelectionChangedFcn = @EstSelCallback;
    
    LinearRadio = uiradiobutton(ButtonGroup, 'Text', 'Linear Estimator');
    LinearRadio.Position = [10 10 200 100];
    LinearRadio.UserData = 1;
    LinearRadio.FontSize = 14;
    KalmanRadio = uiradiobutton(ButtonGroup, 'Text', 'Kalman Estimator');
    KalmanRadio.Position = [170 10 200 100];
    KalmanRadio.UserData = 2;
    KalmanRadio.FontSize = 14;
end