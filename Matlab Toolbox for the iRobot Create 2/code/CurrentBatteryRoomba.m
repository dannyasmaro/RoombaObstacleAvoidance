function [Current] = CurrentBatteryRoomba(serPort)
% [Current] = CurrentTesterRoomba(serPort)
% Reads the current flowing into or out of Create's battery.
% Current is in amps.
% Negative currents indicate that current is flowing out of the battery.
% Positive currents indicate that current is flowing into the battery (charging).
% serPort is a serial port object created by RoombaInit
% By Joel Esposito, US Naval Academy, 2015

%Initialize preliminary return values
Current = nan;

try
    
    %Flush Buffer
    N = serPort.BytesAvailable();
    while(N~=0)
        fread(serPort,N);
        N = serPort.BytesAvailable();
    end
    
    fwrite(serPort, [142]);  fwrite(serPort,23);
    Current = fread(serPort, 1, 'int16')/1000;
    
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end
