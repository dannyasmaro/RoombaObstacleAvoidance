function [AngleR] = AngleSensorRoomba(serPort)
% [AngleR] = AngleSensorRoomba(serPort)
% Displays the angle in radians that Create has turned since the angle was last requested.
% AngleR is in radians, counter-clockwise angles are positive and clockwise angles are negative.
% serPort is a serial port object created by RoombaInit.
% -------------
% NOTE: This command may not work correctly on older versions of
% the Roomba Open Interface (pre 3.3.0).  Line 27 contains a 
% correction factor (/0.324956) that may need to be removed in the future consider using
% EncoderSensorRoomba.  AngleR = (RightWheelDist-LeftWheelDist)/WheelBase,
% where WheelBase = 0.235
% By Joel Esposito, US Naval Academy, 2015

%Initialize preliminary return values
AngleR = nan;

try
    %Flush Buffer
    N = serPort.BytesAvailable();
    while(N~=0)
        fread(serPort,N);
        N = serPort.BytesAvailable();
    end
    
    fwrite(serPort, [142]);  fwrite(serPort,20);
    AngleR = fread(serPort, 1, 'int16')*pi/180;
    AngleR = AngleR/0.324956; %COMMENT OUT THIS LINE IF NEEDED:  the extra factor /0.324956 is from the OI documentation dated 8/15/2015  on Packet 20.  If the bug is fixed in future versions comment out this line. 
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end