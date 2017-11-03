function [LeftCounts, RightCounts] = EncoderSensorsRoomba(serPort)
% [LeftCounts, RightCounts] = EncoderSensor(serPort)
% LeftCounts and RightCounts are the drive wheel encoder counts
% The wheels have 508.8 counts per revolution (0.7075 deg/count).
% Counts wrap around to 0 after exceeding +/- 32767.
% serPort is a serial port object created by RoombaInit.
% Notes:
% (1) Because the physical encoders do not have quadrature, they are
% incapable of directly sensing the direction of travel -- rather they
% infer the direction based on the commanded velocity.  Therefore the sign
% may be incorrect when wheel spin direction does not match the commanded
% velocity.  Examples of such situations include: robot being pushed or
% coasting when not powered.
% (2) the wheel radius is 36 mm, so the distance traveled can be computed using
% Counts* pi*2*0.036/ 508.8
% By Joel Esposito, US Naval Academy, 2015

%Initialize preliminary return values
LeftCounts = nan;
RightCounts = nan;

try
    
    %Flush Buffer
    N = serPort.BytesAvailable();
    while(N~=0)
        fread(serPort,N);
        N = serPort.BytesAvailable();
    end
    
    fwrite(serPort, [142]);  fwrite(serPort,43);  %left request
    LeftCounts = fread(serPort, 1, 'int16');
    
    fwrite(serPort, [142]);  fwrite(serPort,44);  %right request
    RightCounts = fread(serPort, 1, 'int16');
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end
