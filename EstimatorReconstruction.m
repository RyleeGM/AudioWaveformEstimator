%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EstimatorReconstruction: This function creates the main window and 
% manages the operation of the Random Signals Filtering GUI.
% See structure tree below for UI element realtionships
%
% Author: Rylee Mattingly
% Version: 0.0.1
% Creation Date: 11.20.2020
%
%-------------------------------------------------------------------------%
% Window
% +-- RootView
%     +--LeftContainer
%        +--PlotPan
%        +--ReportPane
%        +--PlayPane
%
%     +--RightContainer
%        +--EstSelPane
%        +--AudSelPane
%        +--InputPane
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function EstimatorReconstruction()
    close all force;                                                     
    clc;
    clear all;
    
    %Name of available audio files.
    AudioMembers = {'Chirp   ', 'Gong    ', 'Handel  ', 'Splat   ',...
      'Train   ', 'Laughter', 'Acoustic Song'};
  
    %Create the window and set its name and size
    Window = uifigure('Name', 'Estimator Reconstruction');        
    Window.Position = [0 1000 1920 1000];

    %RootView layout 
    RootView = uigridlayout(Window, [1,2]);
    RootView.ColumnWidth = {'3x', '0.75x'};
    RootView.UserData = {cell(1,7), cell(1,7), cell(1,7), cell(1,7),...
                         cell(1,7), cell(1,7), cell(1,7)};
    
    %Load the audio samples into the root view user data
    %Manually, because I enjoy pain and bad code apparently...
    Fs = load('chirp.mat').Fs;
    RootView.UserData{1}(1) = {load('chirp.mat').y};
    RootView.UserData{1}(2) = {load('gong.mat').y};
    RootView.UserData{1}(3) = {load('handel.mat').y};
    RootView.UserData{1}(4) = {load('splat.mat').y};
    RootView.UserData{1}(5) = {load('train.mat').y};
    RootView.UserData{1}(6) = {load('laughter.mat').y};
    track = audioread('bensound-memories.mp3');
    track = track(10000:(44100*4 + 10000), 2);
    RootView.UserData{1}(7) = {track};
    
    %% Create the LeftContainer and its children
    LeftContainer = uigridlayout(RootView, [3, 1]);
    LeftContainer.RowHeight = {'3x', '.4x', '1x'};
    LeftContainer.RowSpacing = 5;
    
    PlotPane = uipanel(LeftContainer);
    DrawPlotAxis(PlotPane);
    
    ReportPane = uipanel(LeftContainer);
    DrawReportPane(ReportPane);
    
    PlayPane = uipanel(LeftContainer);
    DrawPlayPane(PlayPane);

    %% Create the RightContainer and its children
    RightContainer = uigridlayout(RootView, [3, 1]);
    RightContainer.RowHeight = {'1x', '3x', '1.25x'};
    RightContainer.RowSpacing = 5;
    
    EstSelPane = uipanel(RightContainer);
    EstSelPane.UserData = 1;
    DrawEstSelPane(EstSelPane);
    
    AudSelPane = uipanel(RightContainer);
    AudSelPane.UserData = {1, AudioMembers};
    DrawAudSelPane(AudSelPane);
    
    InputPane = uipanel(RightContainer);
    InputPane.UserData = [2 5];
    DrawInputPane(InputPane);
    
    MasterUpdate(PlayPane);
    
    %% Initialization that must happen at the end.
    PlayPane.Children.UserData = audioplayer(RootView.UserData{1}{AudSelPane.UserData{1}}, Fs);
    PlayPane.Children.UserData.StopFcn = {@PlayPauseCallback, PlayPane};
end