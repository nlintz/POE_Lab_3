function PID_Parameter_Sweep(finalPosition)
    sweep_resolution = 10;
    Kp = linspace(0, 1, sweep_resolution);
    Kd = linspace(0, .1, sweep_resolution);
    Ki = linspace(0, .1, sweep_resolution);
    duration = 1000;
    desiredPosition = ones(duration).*finalPosition;
%     RMS = zeros(sweep_resolution^3, 4);
    
    for i = 1:sweep_resolution
        for j = 1:sweep_resolution
            for k = 1:sweep_resolution
                position = PIDController(Kp(i), Kd(j), Ki(k), 90, .005, duration, 1);
            end
        end
    end

end

function res = RMS_Error(desiredPosition, actualPosition)
    difference = desiredPosition - actualPosition;
    squaredError = difference .^ 2;
    meanSquaredError = sum(squaredError(:)) / numel(image1);
    res = sqrt(meanSquaredError);
end