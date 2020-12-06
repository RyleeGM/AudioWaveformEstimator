%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% InputPaneCallback: This function assigns the approprieate values to the
% PassedPanel and calls for a Master Update.
%
% Author: Rylee Mattingly
% Version: 0.0.1
% Creation Date: 12.3.2020
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function InputPaneCallback(src, event)

    %Get the PassedPanel from src.
    PassedPanel = src.Parent.Parent.Parent;
    Grid = src.Parent;
    PassedPanel.UserData = [Grid.Children(2).Value...
                            Grid.Children(5).Value];

    MasterUpdate(PassedPanel);


end