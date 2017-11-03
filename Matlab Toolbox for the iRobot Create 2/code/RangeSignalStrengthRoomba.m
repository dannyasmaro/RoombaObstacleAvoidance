function [Signal] = RangeSignalStrengthRoomba(serPort)
% [Signal] = RangeSignalStrengthRoomba(serPort)
% Displays the return strength of the 6 IR range sensors located on the
% bumper.
% Signal is a 1 by 6 vector whose entries are Left, FrontLeft, CenterLeft, CenterRight, FrontRight, Right
% with values ranging between 0-4095 but I have not observed values above 1500.
% High values indicate an object is close, low values far away
% serPort is a serial port object created by RoombaInit.
% By Joel Esposito, US Naval Academy, 2015

%Initialize preliminary return values
Signal = [nan, nan, nan, nan , nan, nan];

try
    
    %Flush Buffer
    N = serPort.BytesAvailable();
    while(N~=0)
        fread(serPort,N);
        N = serPort.BytesAvailable();
    end
    
    fwrite(serPort, [142]);  fwrite(serPort,46);
    Signal(1) =  fread(serPort, 1, 'uint16');
    
    fwrite(serPort, [142]);  fwrite(serPort,47);
    Signal(2) =  fread(serPort, 1, 'uint16');
    
    fwrite(serPort, [142]);  fwrite(serPort,48);
    Signal(3) =  fread(serPort, 1, 'uint16');
    
    fwrite(serPort, [142]);  fwrite(serPort,49);
    Signal(4) =  fread(serPort, 1, 'uint16');
    
    fwrite(serPort, [142]);  fwrite(serPort,50);
    Signal(5) =  fread(serPort, 1, 'uint16');
    
    fwrite(serPort, [142]);  fwrite(serPort,51);
    Signal(6) =  fread(serPort, 1, 'uint16');
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end

