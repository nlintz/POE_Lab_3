%create serial object and open it.
function angle = collectData(dataLength)
    delete(instrfind);
    port = '/dev/tty.usbmodem1431';
    s = serial(port);
    set(s,'BaudRate',9600);
    set(s,'DataBits',8);
    fopen(s);
    s.ReadAsyncMode = 'continuous'; 
    
    angle = zeros(dataLength, 2);
    i = 1;
    while (i<(dataLength+1))
        [data count errmsg] = fscanf(s, 'Potentiometer Angle: %i Desired Angle: %f');
        data
        length(data)
        if (length(data) == 2)
            angle(i, 1) = data(1);
            angle(i, 2) = data(2);
            i = i+1;
        end
    end
end