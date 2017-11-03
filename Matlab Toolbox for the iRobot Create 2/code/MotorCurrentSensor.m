function [LeftAmp, RightAmp] = MotorCurrentSensor(serPort)
% [LeftAmp, RightAmp] = MotorCurrentSensor(serPort)
% Get motor currents.
% LeftAmp and RightAmp are signed left and right drive wheel current draws in amps
% serPort is a serial port object created by RoombaInit
% By Joel Esposito, US Naval Academy, 2015

%Initialize preliminary return values
LeftAmp = nan;
RightAmp = nan;

try
    
    %Flush Buffer
    N = serPort.BytesAvailable();
    while(N~=0)
        fread(serPort,N);
        N = serPort.BytesAvailable();
    end
    
    fwrite(serPort, [142]);  fwrite(serPort,54);  %left request
    LeftAmp = fread(serPort, 1, 'int16')/1000;
    
    fwrite(serPort, [142]);  fwrite(serPort,55);  %right request
    RightAmp = fread(serPort, 1, 'int16')/1000;
    
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end
