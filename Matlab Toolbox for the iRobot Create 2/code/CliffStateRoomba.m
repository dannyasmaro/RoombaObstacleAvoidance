function [State] = CliffStateRoomba(serPort)
% [state] = CliffStateRoomba(serPort)
% Specifies the state of the Cliff sensor
% State is a 1 X 4 vector [Left, LeftFront, RightFront, Right]
% where 1 indicates the cliff sensor is triggered while 0 indicates not
% triggered.
% serPort is a serial port object created by RoombaInit
% By Joel Esposito, US Naval Academy, 2015

%Initialize preliminary return values
state = [nan, nan, nan, nan];

try
    %Flush Buffer
    N = serPort.BytesAvailable();
    while(N~=0)
        fread(serPort,N);
        N = serPort.BytesAvailable();
    end
    
    
    fwrite(serPort, [142]);  fwrite(serPort,9);
    C = dec2bin(fread(serPort, 1));
    State(1) = bin2dec(C(end));
    
    fwrite(serPort, [142]);  fwrite(serPort,10);
    C = dec2bin(fread(serPort, 1));
    State(2) = bin2dec(C(end));
    
    fwrite(serPort, [142]);  fwrite(serPort,11);
    C = dec2bin(fread(serPort, 1));
    State(3) = bin2dec(C(end));
    
    fwrite(serPort, [142]);  fwrite(serPort,12);
    C = dec2bin(fread(serPort, 1));
    State(4) = bin2dec(C(end));

catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end
