function [Distance] = DistanceSensorRoomba(serPort)
% [Distance] = DistanceSensorRoomba(serPort)
% Gives the distance traveled since last queried.
% Distance is in meters, positive
% values indicate travel in the forward direction and negative values indicate
% travel in the reverse direction. If not polled frequently enough, it is
% capped at its minimum or maximum of +/- 32.768 meters.
% serPort is a serial port object created by RoombaInit.
% ---------------------------
% Note: API indicates that this reading is incorrect on robots with old
% firmware (pre 3.3.0).   Consider using EncoderSensorsRoomba instead.
% (RightWheelDist+LeftWheelDist)/2
% By Joel Esposito, US Naval Academy, 2015

%Initialize preliminary return values
Distance = nan;

try
    
    %Flush Buffer
    N = serPort.BytesAvailable();
    while(N~=0)
        fread(serPort,N);
        N = serPort.BytesAvailable();
    end
    
    fwrite(serPort, [142]);  fwrite(serPort,19);
    
    Distance = fread(serPort, 1, 'int16')/1000;
    if (Distance > 32) || (Distance <-32)
        disp('Warning:  May have overflowed')
    end
    
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end
