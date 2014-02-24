function ZieglerNichols_Test()
    Ku = 1;
    Tu = 1;
    Kp = .6*Ku;
    Ki = 2*Kp/Tu;
    Kd = Kp*Tu/8;
    duration = 1000;
    position = PIDController(Kp, Kd, Ki, 90, .005, duration, 1);
    plot(linspace(0, length(position), duration), position);

end