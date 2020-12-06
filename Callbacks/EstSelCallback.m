%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EstSelCallback: This function updates the value in the root pane with the
% new button select number and then calls the master update.
%
% Author: Rylee Mattingly
% Version: 0.0.1
% Creation Date: 12.3.2020
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function EstSelCallback (src, event)

    %Assign the new value to the PassedPanel
    PassedPanel = src.Parent.Parent;
    PassedPanel.UserData = event.NewValue.UserData;

    %Mass update
    MasterUpdate(PassedPanel);
    
end