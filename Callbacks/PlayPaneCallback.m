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
    EstimatorSelect = RootView.Children(2).Children(1).UserData(1) - 1;
    
    TypeSelect = event.NewValue.UserData;
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
    
    AudioGrid.UserData = audioplayer(RootView.UserData{TypeSelect}{Select}, Fs);
    AudioGrid.UserData.StopFcn = {@PlayPauseCallback, PlayPane};

end