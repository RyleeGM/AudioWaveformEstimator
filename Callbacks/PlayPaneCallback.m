%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PlayPaneCallback: This function reinitializes the audioplayer with the
% correct signal type.
%
% Author: Rylee Mattingly
% Version: 0.0.1
% Creation Date: 12.3.2020
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function PlayPaneCallback(src, event)

    AudioGrid = src.Parent;
    RootView = AudioGrid.Parent.Parent.Parent;
    PlayPane = RootView.Children(1).Children(3);
    AudSelPane = RootView.Children(2).Children(2);
    
    AudioGrid.UserData = audioplayer(RootView.UserData{event.NewValue.UserData}{AudSelPane.UserData{1}}, 8192);
    AudioGrid.UserData.StopFcn = {@PlayPauseCallback, PlayPane};

end