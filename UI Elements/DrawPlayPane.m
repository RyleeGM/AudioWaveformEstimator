%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DrawPlayPane: This function creates a Play/Pause Button that allows us to
% play the sound that is currently queued up.
%
% Author: Rylee Mattingly
% Version: 0.0.1
% Creation Date: 12.3.2020
%
%-------------------------------------------------------------------------%
% PassedPanel
%   +--AudioGrid
%      +--TitleLabel
%      +--SigSelGroup
%         +--CleanSigButton +--NoisySigButton +--FiltSigButton
%      +--PlayPauseGrid
%         +--PlayPause
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function DrawPlayPane(PassedPane)

    AudioGrid = uigridlayout(PassedPane, [3 1]);
    AudioGrid.RowHeight = {'0.75x', '2x', '2x'};
    
    TitleLabel = uilabel(AudioGrid, 'Text', 'Signal Player');
    TitleLabel.FontSize = 15;
    TitleLabel.FontWeight = 'bold';
    TitleLabel.HorizontalAlignment = 'center';

    SigSelGroup = uibuttongroup(AudioGrid);
    SigSelGroup.BorderType = 'none';
    SigSelGroup.SelectionChangedFcn = @PlayPaneCallback;
    
    CleanSigButton = uiradiobutton(SigSelGroup);
    CleanSigButton.Text = 'Clean Signal';
    CleanSigButton.Position = [150 20 200 50];
    CleanSigButton.FontSize = 14;
    CleanSigButton.UserData = 1;
    
    NoisySigButton = uiradiobutton(SigSelGroup);
    NoisySigButton.Text = 'Noisy Intput Signal';
    NoisySigButton.Position = [675 20 200 50];
    NoisySigButton.FontSize = 14;
    NoisySigButton.UserData = 2;
    
    FiltSigButton = uiradiobutton(SigSelGroup);
    FiltSigButton.Text = 'Reconstructred Output Signal';
    FiltSigButton.Position = [1150 20 300 50];
    FiltSigButton.FontSize = 14;
    FiltSigButton.UserData = 3;
    
    PlayPauseGrid = uigridlayout(AudioGrid, [1 3]);
    PlayPauseGrid.ColumnWidth = {'1x' '1x' '1x'};
    
    PlayPause = uibutton(PlayPauseGrid);
    PlayPause.Text = 'Play';
    PlayPause.Layout.Column = 2;
    PlayPause.FontSize = 14;
    PlayPause.ButtonPushedFcn = @PlayPauseCallback;
    
end