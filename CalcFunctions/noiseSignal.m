%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name:    noiseSignal
% Author:  Kyle Kanaly
% Purpose: Returns a signal that is the combination 
%          of the input signal and some randomly normal
%          distributed noise, satifying the desired SNR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [NoiseySignal, NoiseySignalFFT] = noiseSignal(Signal,SNR)

    RMSsig  = rms(Signal);

    % Generating our noise
    RMS_noise = sqrt((RMSsig.^2)./db2pow(SNR));
    noise     = normrnd(0,RMS_noise,1,length(Signal));

    % Adding our noise to the signal
    NoiseySignal = Signal + noise.';
    
    NoiseySignalFFT = abs(fftshift(fft(NoiseySignal)));
    NoiseySignalFFT = NoiseySignalFFT(round(length(NoiseySignalFFT)/2):round(length(NoiseySignalFFT)));
    
end

