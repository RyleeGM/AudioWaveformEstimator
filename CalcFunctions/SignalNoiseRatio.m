function [SNR] = SignalNoiseRatio(FilterSignal,Signal)

    leftOverNoise = FilterSignal - Signal;
    SNR = 10.*log10(((rms(Signal)).^2)./((rms(leftOverNoise)).^2));

end

