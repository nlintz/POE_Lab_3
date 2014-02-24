function PIDController_I_Test()
    Kp = 1;
    Kd = .5;
    Ki = .1;
    duration = 1000;
    position = PIDController(Kp, Kd, Ki, 90, .005, duration, 1);
    plot(linspace(0, length(position), duration), position);
end