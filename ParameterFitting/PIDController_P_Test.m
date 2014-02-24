function PIDController_P_Test()
    Kp = 1;
    duration = 1000;
    position = PIDController(Kp, 0, 0, 90, .005, duration, 1);
    plot(linspace(0, length(position), duration), position);
end