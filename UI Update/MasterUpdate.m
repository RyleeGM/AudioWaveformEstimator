%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MasterUpdate: This function is called by all of the user mutable 
% UI elements and is used to update all of the display objects. By
% extracting the changed values from each Panel container derived from the
% root window which is derived from the passed element.
%
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

    %Define plot handles.
    Axis1 = RootView.Children(1).Children(1).Children.Children(1).Children;
    Axis2 = RootView.Children(1).Children(1).Children.Children(2).Children;
    Axis3 = RootView.Children(1).Children(1).Children.Children(3).Children;
    Axis4 = RootView.Children(1).Children(1).Children.Children(4).Children;

   %Grab Clean input based on Audio Select.
    CleanSignal = RootView.UserData{1}{AudioSelect};
    CleanSignalFFT = abs(fftshift(fft(CleanSignal)));
    CleanSignalFFT = CleanSignalFFT(round(length(CleanSignalFFT)/2):round(length(CleanSignalFFT)));
    
    %Only Recalculate analysis if not the Estimator Select panel.
    if(PanelChanged ~= RootView.Children(2).Children(1))

        %Add Noise to the signal.
        [RootView.UserData{2}{AudioSelect},...
         RootView.UserData{5}{AudioSelect}] = noiseSignal(CleanSignal, SNRin);

        %Set wait status.
        RootView.Parent.Pointer = 'watch';

        %Determine sample rate
        if AudioSelect > 6
            Fs = 44100;
        else
            Fs = 8192;
        end

        %Run the linear filter.
        [RootView.UserData{3}{AudioSelect},...
         RootView.UserData{6}{AudioSelect}] = MatlabLinearPrediction(RootView.UserData{2}{AudioSelect}, FilterOrder);

        %Run the kalman filter.
        KalmanFiltSignal = kalman_est(RootView.UserData{2}{AudioSelect},FilterOrder,Fs);
        KalmanFiltSignalFFT = abs(fftshift(fft(KalmanFiltSignal)));
        KalmanFiltSignalFFT = KalmanFiltSignalFFT(round(length(KalmanFiltSignalFFT)/2):(round(length(KalmanFiltSignalFFT))));

        RootView.UserData{4}{AudioSelect} = KalmanFiltSignal;
        RootView.UserData{7}{AudioSelect} = KalmanFiltSignalFFT;

        %Completion Marked
        RootView.Parent.Pointer = 'arrow';

        %Calculate the output SNR.
        LinearSNRout = SignalNoiseRatio(RootView.UserData{3}{AudioSelect},...
                                        CleanSignal);
        KalmanSNRout = SignalNoiseRatio(RootView.UserData{4}{AudioSelect},...
                                         CleanSignal);

        %Mean Square errors
        LinearNoisyMSE = mean((CleanSignal - RootView.UserData{2}{AudioSelect}).^2);
        LinearCleanMSE = mean((CleanSignal - RootView.UserData{3}{AudioSelect}).^2);
        KalmanNoisyMSE = mean((CleanSignal - RootView.UserData{2}{AudioSelect}).^2);
        KalmanCleanMSE = mean((CleanSignal - RootView.UserData{4}{AudioSelect}).^2);

        %Update Resultant Data Fields for Linear.
        RootView.Children(1).Children(2).Children.Children(2).Text...
                             = strcat("Noisy Mean Squared Error: ", num2str(LinearNoisyMSE, 4)); 
        RootView.Children(1).Children(2).Children.Children(3).Text...
                             = strcat("Filtered Mean Squared Error: ", num2str(LinearCleanMSE, 4)); 
        RootView.Children(1).Children(2).Children.Children(4).Text...
                             = strcat("MSE Difference: ", num2str(LinearNoisyMSE - LinearCleanMSE, 4));
        RootView.Children(1).Children(2).Children.Children(5).Text...
                             = strcat("SNRout: ", num2str(LinearSNRout, 5));

        %UpdateFields Resultant Data Fields for Kalman.
        RootView.Children(1).Children(2).Children.Children(7).Text...
                             = strcat("Noisy Mean Squared Error: ", num2str(KalmanNoisyMSE, 4)); 
        RootView.Children(1).Children(2).Children.Children(8).Text...
                             = strcat("Filtered Mean Squared Error: ", num2str(KalmanCleanMSE, 4)); 
        RootView.Children(1).Children(2).Children.Children(9).Text...
                             = strcat("MSE Difference: ", num2str(KalmanNoisyMSE - KalmanCleanMSE, 4));
        RootView.Children(1).Children(2).Children.Children(10).Text...
                             = strcat("SNRout: ", num2str(KalmanSNRout));
    end 
    
    cla(Axis1(2));
    hold(Axis1(2), 'on');
    plot(Axis1(2), RootView.UserData{2}{AudioSelect});
    plot(Axis1(2), RootView.UserData{EstimatorType + 2}{AudioSelect});
    legend(Axis1(2), 'Noisy Input Signal', 'Reconstructed Output Signal');
    Ylim = Axis1(2).YLim;
    hold(Axis1(2), 'off');

    cla(Axis2(2));
    hold(Axis2(2), 'on');
    plot(Axis2(2), RootView.UserData{1}{AudioSelect}, 'g');
    plot(Axis2(2), RootView.UserData{EstimatorType + 2}{AudioSelect});
    legend(Axis2(2), 'Clean Original Signal', 'Reconstructed Output Signal');
    Axis2(2).YLim = Ylim;
    hold(Axis2(2), 'off');

    cla(Axis3(2));
    hold(Axis3(2), 'on');
    plot(Axis3(2), RootView.UserData{5}{AudioSelect});
    plot(Axis3(2), RootView.UserData{EstimatorType + 5}{AudioSelect});
    Ylim = Axis3(2).YLim;
    legend(Axis3(2), 'Noisy Input Signal', 'Reconstructed Output Signal');
    hold(Axis3(2), 'off');

    cla(Axis4(2));
    hold(Axis4(2), 'on');
    plot(Axis4(2), CleanSignalFFT, 'g');
    plot(Axis4(2), RootView.UserData{EstimatorType + 5}{AudioSelect});
    Axis4(2).YLim = Ylim;
    legend(Axis4(2), 'Clean Original Signal', 'Reconstructed Output Signal');
    hold(Axis4(2), 'off');

end