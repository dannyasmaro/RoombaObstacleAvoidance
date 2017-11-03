function [Signal] = CliffSignalStrengthRoomba(serPort)
% [Signal] = CliffSignalRoomba(serPort)
% Displays the strength cliff sensor signals.
% Signal is a 1X4 array [Left, LeftFront, RightFront, Right]
% which ranges between 0-4095.  Higher values indicate an object is closer (no cliff) and
% smaller values indicate an object is further (possible cliff).   Under
% normal driving conditions values are approximately 3000, but vary with
% surface reflectivity. 
% serPort is a serial port object created with RoombaInit
% Note: I have never observed values close to 4095.
% By Joel Esposito, US Naval Academy, 2015

%Initialize preliminary return values
Signal = [nan, nan, nan, nan];

try
    %Flush Buffer
    N = serPort.BytesAvailable();
    while(N~=0)
        fread(serPort,N);
        N = serPort.BytesAvailable();
    end
    
    fwrite(serPort, [142]);  fwrite(serPort,28);
    Signal(1) =  fread(serPort, 1, 'uint16');
    
    fwrite(serPort, [142]);  fwrite(serPort,29);
    Signal(2) =  fread(serPort, 1, 'uint16');
    
    fwrite(serPort, [142]);  fwrite(serPort,30);
    Signal(3) =  fread(serPort, 1, 'uint16');
    
    fwrite(serPort, [142]);  fwrite(serPort,31);
    Signal(4) =  fread(serPort, 1, 'uint16');
 
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end
