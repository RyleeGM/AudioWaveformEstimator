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

    RootView = PassedPanel.Parent.Parent;
    AudioGrid = RootView.Children(1).Children(3).Children;
    ButtonGroup = AudioGrid.Children(2);
    AudSelPane = RootView.Children(2).Children(2);
    EstimatorSelect = RootView.Children(2).Children(1).UserData(1) - 1;
    
    TypeSelect = ButtonGroup.SelectedObject.UserData;
    %Select which version of the audio signal.
    if TypeSelect == 3
        TypeSelect = TypeSelect + EstimatorSelect;
    end
    
    Select = AudSelPane.UserData{1};
    
    if Select > 6
        Fs = 44100;
    else
        Fs = 8192;
    end
    
    AudioGrid.UserData = audioplayer(...
           RootView.UserData{TypeSelect}...
           {Select}, Fs);
   AudioGrid.UserData.StopFcn = {@PlayPauseCallback, AudioGrid.Parent};
    
    
    %Mass update
    MasterUpdate(PassedPanel);
    
end