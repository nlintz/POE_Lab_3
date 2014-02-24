function PIDController_P_Test()
    Kp = 22;
    duration = 1000;
    position = PIDController(Kp, 0, 0, 90, .001, duration, 22.6);
    plot(linspace(0, length(position), duration), position);
end