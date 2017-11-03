function Temp = TemperatureRoomba(serPort)
% [Temp] =  TemperatureRoomba(serPort)
% Get robot's temperature.
% Temp is battery temp in degrees C.
% serPort is a serial port object created by Roombainit
% By Joel Esposito, US Naval Academy, 2015

%Initialize preliminary return values
Temp = nan;

try
    %Flush Buffer
    N = serPort.BytesAvailable();
    while(N~=0)
        fread(serPort,N);
        N = serPort.BytesAvailable();
    end
    fwrite(serPort, [142]);  fwrite(serPort,24);
    Temp = fread(serPort, 1, 'int8');
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end