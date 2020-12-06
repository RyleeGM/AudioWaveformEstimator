function filteredAudio = kalman_est(noisyAudio,order,sampRate)
    %% Simulate Kalman Filter Data

    M = order;    %Order of the LPC
    output = 0;

    % Create a time vector to perform the simulations over
    dt = 1/sampRate; % Time step
    end_time = length(noisyAudio)/sampRate;
    t = 0:dt:end_time; % Time vector

     % Find variance of observation noise
    factor = 20;
     seg = zeros(floor(length(noisyAudio)/factor),1);

     %Calculate variance of many little segments, assume the smallest comes
     %from a segment with very little true audio, mostly just noise, to get the
     %variance of noise.
     for s = 1:length(seg)
         seg(s) = var(noisyAudio(((s-1)*factor+1):(s*factor)));
     end
    var_n = min(seg); % Variance of the additive white noise, observation


    % For each segment:
    groupTime = 20E-3;    %Length of each group for processing
    groupLength = floor(groupTime*sampRate);
    numGroups = floor(end_time/groupTime);
    % groupLength = length(track);
    % numGroups = 1;

    % groupLength = 132300;
    % numGroups = 1;

    % Create matrix to store the state variables
    % Actual State
    x = zeros(M,length(t));

    % Estimated State
    xk = zeros(M,groupLength);

    for b = 1:numGroups
        startIdx = (b-1)*groupLength+1;
        stopIdx = b*groupLength;
        t_seg = t(startIdx:stopIdx);
        noisySegment = noisyAudio(startIdx:stopIdx);
        [a,g] = lpc(noisySegment,M); %Returns coefficients of a and variance of the prediction error g     
        % Create the state-transition matrix F
        I = eye(M-1);
        top = cat(2,zeros(M-1,1),I);
        F = cat(1,top,fliplr(a(2:end)));
        % 
        % % Create the measurement model matrix H
        H = cat(2,zeros(1,M-1),1);
        %    
        % Create the process covariance Q
        var_u = g-var_n;  % g is total variance, we want just the excitation noise variance

    %     % Create the process noise
    %     n_p = mvnrnd(0,var_u,length(t)).';



        G = cat(1,zeros(M-1,1),1);  % Vector G describes how varied acceleration with 
                            % variance sigma_a^2 interferes with state model
         I = eye(M);
        if b == 1
            % % Create the initial state vector
            xk0 = cat(1,zeros(M-1,1),mean(noisySegment));
            % % Create initial error covariance
            % Should be E[(s(n)-s(0))s(n)-s(0))T];
            Pk0 = I.*(var_n);  %diagonal matrix of the estimated observation noise variance for the first segment
    %         Pk0 = mean(maybeT*maybe);
            x(:,1) = xk0;
            xk(:,1) = xk0;
        else
            %assign the last value to the first value here
        end
        for n=2:length(t_seg)
            % Update the actual state of the object
            x(:,(n + startIdx - 1)) = F*x(:,n-1) + G*(noisySegment(n) - H*F*x(:,n-1));
        end
        for n=2:length(t_seg)  
            % Update the estimated error covariance a priori
            Pk1 = F*Pk0*(F.') + G*var_u*(G.'); %Pk(n|n-1)
            K = Pk1*(H.')*[H*Pk1*(H.') + var_n]^-1;

            %Innovation step
            xk(:,n) = F*xk(:,n-1) + K*[noisySegment(n) - H*F*xk(:,n-1)]; %x(n|n)
            %Update the estimated error covariance a posteriori
            updater = I-K*H;
            Pk0 = updater*Pk1; %P(n:n)
        end
        output = cat(2,output,xk(M,:));
    end
        padding = zeros(1,length(noisyAudio)-length(output)+1);
        filteredAudio = cat(2,output(2:end),padding).';
end
