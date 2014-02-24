function PIDController_D_Test()
    Kp = 1;
    Kd = .5;
    duration = 1000;
    position = PIDController(Kp, Kd, 0, 90, .005, duration, 1);
    plot(linspace(0, length(position), duration), position);
end