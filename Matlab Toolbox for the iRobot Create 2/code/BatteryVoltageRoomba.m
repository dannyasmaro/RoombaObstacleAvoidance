function [Voltage] = BatteryVoltageRoomba(serPort)
% [Voltage] = BatteryVoltageRoomba(serPort)
% Indicates the voltage of Create's battery.
% Voltage is the battery voltage
% serPort is a serial port object created by RoombaInit
% By Joel Esposito, US Naval Academy, 2015

%Initialize preliminary return values
Voltage = nan;

try
    %Flush Buffer
    N = serPort.BytesAvailable();
    while(N~=0)
        fread(serPort,N);
        N = serPort.BytesAvailable();
    end
    
    fwrite(serPort, [142]);  fwrite(serPort,22);
    Voltage = fread(serPort, 1, 'uint16')/1000;
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end