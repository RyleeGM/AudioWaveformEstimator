%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DrawInputPane: This function creates the necessary input parameter
% fields.
%
% Author: Rylee Mattingly
% Version: 0.0.1
% Creation Date: 12.3.2020
%
%-------------------------------------------------------------------------%
% PassedPanel
%   +--InputGrid
%      +--TitleLabel
%      +--FieldGrid
%         +--InSNRLabel          +--InSNRField          +--InSNRUnit
%         +--FilterOrderLabel    +--FilterOrderField 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function DrawInputPane(PassedPanel)

    %Create the  input grid. 
    InputGrid = uigridlayout(PassedPanel, [2, 1]);
    InputGrid.RowHeight = {'0.75x', '3x'}; 

    %Create the title label.
    TitleLabel = uilabel(InputGrid);
    TitleLabel.Text = 'Input Parameters';
    TitleLabel.HorizontalAlignment = 'center';
    TitleLabel.VerticalAlignment = 'top';
    TitleLabel.FontSize = 15;
    TitleLabel.FontWeight = 'bold';

    %Create the FieldGrid layout
    FieldGrid = uigridlayout(InputGrid, [2, 3]);
    
    %InSNRLabel
    InSNRLabel = uilabel(FieldGrid);
    InSNRLabel.Text = 'Input SNR:';
    InSNRLabel.HorizontalAlignment = 'right';
    InSNRLabel.FontSize = 14;
    InSNRLabel.FontWeight = 'bold';
    
    %InSNRField
    InSNRField = uieditfield(FieldGrid, 'numeric');
    InSNRField.Tooltip = 'The SNR of the input signal in dB';
    InSNRField.Value = 2;
    InSNRField.FontSize = 14;
    InSNRField.ValueChangedFcn = @InputPaneCallback;
    
    %InSNRUnit
    InSNRUnit = uilabel(FieldGrid);
    InSNRUnit.Text = 'dB';
    InSNRUnit.HorizontalAlignment = 'left';
    InSNRUnit.FontSize = 14;
    InSNRUnit.FontWeight = 'bold';
    
    %FilterOrderLabel
    FilterOrderLabel = uilabel(FieldGrid);
    FilterOrderLabel.Text = 'Filter Order:';
    FilterOrderLabel.HorizontalAlignment = 'right';
    FilterOrderLabel.FontSize = 14;
    FilterOrderLabel.FontWeight = 'bold';
    
    %FilterOrderField
    FilterOrderField = uieditfield(FieldGrid, 'numeric');
    FilterOrderField.Value = 5;
    FilterOrderField.FontSize = 14;
    FilterOrderField.ValueChangedFcn = @InputPaneCallback;
    
end