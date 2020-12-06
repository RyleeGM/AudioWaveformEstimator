%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AudSelCallback: This function updates the value in the root pane with the
% new audio selected number and then calls for a Master Update
%
% Author: Rylee Mattingly
% Version: 0.0.1
% Creation Date: 12.3.2020
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function AudSelCallback(src, event)

    %Find the PassedPanel
    PassedPanel = src.Parent.Parent;
    PassedPanel.UserData(1) = num2cell(event.Value);
    
    MasterUpdate(PassedPanel);
    
    %Update the audio player
    RootView = PassedPanel.Parent.Parent;
    AudioGrid = RootView.Children(1).Children(3).Children;
    ButtonGroup = AudioGrid.Children(2);
    
    AudioGrid.UserData = audioplayer(...
           RootView.UserData{ButtonGroup.SelectedObject.UserData}...
           {PassedPanel.UserData{1}}, 8192);

end