function res = PIDController(Kp, Ki, Kd, desired_position, timeStep, duration, transduction_constant)
    position = 0;
    cumulative_error = 0;
    previous_error = 0;
    positions = zeros(0, duration);
    for i=1:duration
        error = desired_position - position;
        cumulative_error = cumulative_error + error;
        response = error*Kp + cumulative_error * Ki + (error - previous_error) * Kd;
        position = position + response*timeStep*transduction_constant;
        positions(i) = position;
        previous_error = error;
    end
    res = positions;
end