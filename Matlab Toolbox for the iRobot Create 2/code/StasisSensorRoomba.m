function [state] = StasisSensorRoomba(serPort)
% [state] = StasisSensorRoomba(serPort)
% State 0 indicates no forward progress (backway, stationary, or turn in place)
% a warning is issued if the sensor is too dirty to be read.
% a value of 1 indicates forward progess being made.
% serPort is a serial port object created by Roombainit
% By Joel Esposito, US Naval Academy, 2015

%Initialize preliminary return values
state = nan;
try
    %Flush Buffer
    N = serPort.BytesAvailable();
    while(N~=0)
        fread(serPort,N);
        N = serPort.BytesAvailable();
    end
    
    fwrite(serPort, [142]);  fwrite(serPort,58);
    CliffFrntLft = dec2bin(fread(serPort, 1));
    state = bin2dec(CliffFrntLft(end));
    if state ==2
        warning('Stasis sensor too dirty to read.  Remove caster and clean.')
        state = 0;
    end
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end
