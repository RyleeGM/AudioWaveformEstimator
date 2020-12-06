%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MasterUpdate: This function is called by all of the user mutable 
% UI elements and is used to update all of the display objects. By
% extracting the changed values from each Panel container derived from the
% root window which is derived from the passed element.
%
% Author: Rylee Mattingly
% Version: 0.0.1
% Creation Date: 12.3.2020

%-------------------------------------------------------------------------%
% Update Path:
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function MasterUpdate(PanelChanged)

    %Extract the root panel.
    RootView = PanelChanged.Parent.Parent;

    %Go throught the update precedure using the changed data.
    EstimatorType = RootView.Children(2).Children(1).UserData(1);
    S = RootView.Children(2).Children(3).UserData;
    SNRin = S(1);
    FilterOrder = S(2);
    AudioSelect = RootView.Children(2).Children(2).UserData{1};
    
    %Define Plots
    Axis1 = RootView.Children(1).Children(1).Children.Children(1).Children;
    Axis2 = RootView.Children(1).Children(1).Children.Children(2).Children;
    Axis3 = RootView.Children(1).Children(1).Children.Children(3).Children;
    Axis4 = RootView.Children(1).Children(1).Children.Children(4).Children;
    
    
    %Grab Clean input based on Audio Select.
    CleanSignal = RootView.UserData{1}{AudioSelect};
    CleanSignalFFT = abs(fftshift(fft(CleanSignal)));
    CleanSignalFFT = CleanSignalFFT(round(length(CleanSignalFFT)/2):round(length(CleanSignalFFT)));

    Select = RootView.Children(2).Children(2).UserData{1};
    
    if Select > 6
        Fs = 44100;
    else
        Fs = 8192;
    end
    
    %Add Noise to the signal.
    [NoisySignal, NoisySignalFFT] = noiseSignal(CleanSignal, SNRin);
    
    RootView.Parent.Pointer = 'watch';
    if EstimatorType == 1
        
        [FilterSignal, FilterSignalFFT] = MatlabLinearPrediction(NoisySignal, FilterOrder);
        
    else
       
        cla(Axis1(2));
        cla(Axis2(2));
        return;
    end
    RootView.Parent.Pointer = 'arrow';
    
    %Calculate the output SNR.
    SNRout = SignalNoiseRatio(FilterSignal, CleanSignal);
    
    %Store Noisy and Filtered Signals.
    RootView.UserData{2}(AudioSelect) = {NoisySignal};
    RootView.UserData{3}(AudioSelect) = {FilterSignal};
    
    %Mean Square error
    NoisyMSE = mean((CleanSignal - NoisySignal).^2);
    CleanMSE = mean((CleanSignal - FilterSignal).^2);
    
    %Update Resultant Data Fields.
    RootView.Children(1).Children(2).Children.Children(3).Children(2).Text = strcat(num2str(SNRout), ' dB'); 
    RootView.Children(1).Children(2).Children.Children(1).Children(2).Text = num2str(NoisyMSE);
    RootView.Children(1).Children(2).Children.Children(2).Children(2).Text = num2str(CleanMSE);
    
    cla(Axis1(2));
    hold(Axis1(2), 'on');
    plot(Axis1(2), NoisySignal);
    plot(Axis1(2), FilterSignal);
    legend(Axis1(2), 'Noisy Input Signal', 'Reconstructed Output Signal');
    Ylim = Axis1(2).YLim;
    hold(Axis1(2), 'off');

    cla(Axis2(2));
    hold(Axis2(2), 'on');
    plot(Axis2(2), CleanSignal);
    plot(Axis2(2), FilterSignal);
    legend(Axis2(2), 'Clean Original Signal', 'Reconstructed Output Signal');
    Axis2(2).YLim = Ylim;
    hold(Axis2(2), 'off');

    cla(Axis3(2));
    hold(Axis3(2), 'on');
    plot(Axis3(2), NoisySignalFFT);
    plot(Axis3(2), FilterSignalFFT);
    Ylim = Axis3(2).YLim;
    legend(Axis3(2), 'Noisy Input Signal', 'Reconstructed Output Signal');
    hold(Axis3(2), 'off');

    cla(Axis4(2));
    hold(Axis4(2), 'on');
    plot(Axis4(2), CleanSignalFFT);
    plot(Axis4(2), FilterSignalFFT);
    Axis4(2).YLim = Ylim;
    legend(Axis4(2), 'Clean Original Signal', 'Reconstructed Output Signal');
    hold(Axis4(2), 'off');

end