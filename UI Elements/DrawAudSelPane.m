%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DrawAudSelPane: This function creates a listbox populated with the
% objects in the first cell of the PassedPanel.
%
% Author: Rylee Mattingly
% Version: 0.0.1
% Creation Date: 12.3.2020
%
%-------------------------------------------------------------------------%
% PassedPanel
%   +--AudioGrid
%      +--AudioTitle
%      +--AudioList
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function DrawAudSelPane (PassedPanel)

    AudioGrid = uigridlayout(PassedPanel, [2 1]);
    AudioGrid.RowHeight = {'0.25x' '5x'};

    AudioTitle = uilabel(AudioGrid);
    AudioTitle.Text = 'Audio Signal Selection';
    AudioTitle.FontSize = 15;
    AudioTitle.HorizontalAlignment = 'center';
    AudioTitle.FontWeight = 'bold';
    
    AudioList = uilistbox(AudioGrid);
    AudioList.Items = PassedPanel.UserData{2};
    AudioList.FontSize = 14;
    AudioList.ItemsData = (1:1:size(PassedPanel.UserData{2}, 2));
    AudioList.ValueChangedFcn = @AudSelCallback;
   
end