function [State] = RangeStateRoomba(serPort)
% [State] = RangeStateRoomba(serPort)
% Displays the state of the 6 IR range sensors located on the bumper.
% State is a 1 by 6 vector [Left, FrontLeft, CenterLeft, CenterRight, FrontRight, Right]
% a value of 0 means no object in range, 1 indicates an object is in range
% serPort is a serial port object created by RoombaInit.
% By Joel Esposito, US Naval Academy, 2015

%Initialize preliminary return values
State = [nan, nan, nan, nan , nan, nan];

try
    
    %Flush Buffer
    N = serPort.BytesAvailable();
    while(N~=0)
        fread(serPort,N);
        N = serPort.BytesAvailable();
    end
    
    fwrite(serPort, [142]);  fwrite(serPort,45);
    raw =  dec2bin(fread(serPort, 1), 8);
    for i = 0:5
        State(i+1)= bin2dec(raw(end-i));
    end
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end

