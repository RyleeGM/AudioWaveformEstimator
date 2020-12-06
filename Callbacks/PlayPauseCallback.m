%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PlayPauseCallback: This function updates the play/pause button and
% manages the audio playing.
%
% Author: Rylee Mattingly
% Version: 0.0.1
% Creation Date: 12.3.2020
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function PlayPauseCallback(src, ~, ExtraPane)

    %If it is the audio ending put the button back and return.
    if class(src) == "audioplayer"
        ExtraPane.Children.Children(3).Children.Text = 'Play';
        return
    end
    
    AudioGrid = src.Parent.Parent;
    
    %If clicking play, play.
    if (src.Text == "Play")
       
        resume(AudioGrid.UserData);
        src.Text = 'Pause';
       
    else
        %If clicking pause, pause.
        pause(AudioGrid.UserData);
        src.Text = 'Play';
        
    end

end