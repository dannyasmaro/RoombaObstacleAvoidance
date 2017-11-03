function [BumpRight,BumpLeft,BumpFront, WheDropRight,WheDropLeft] = BumpsWheelDropsSensorsRoomba(serPort)
% [BumpRight,BumpLeft,BumpFront, WheDropRight,WheDropLeft] = BumpsWheelDropsSensorsRoomba(serPort)
% Queries the state of the bump and wheel drop sensors
% BumpRight,BumpLeft,BumpFront, WheDropRight,WheDropLeft are returned as either triggered
% (1) or not triggered (0)  
% serPort is a serial port object created by RoombaInit
% Note there is no physical front bump sensor, but
% rather it is considered triggered if  both the left and right bump sensors
% are triggered, in which case BumpFront =1 and BumpLeft and BumpRight are returned as 0.
% By Joel Esposito, US Naval Academy, 2015

%Initialize preliminary return values
BumpRight = nan;
BumpLeft = nan;
BumpFront = nan;
WheDropRight = nan;
WheDropLeft = nan;

try
    
    %Flush Buffer
    N = serPort.BytesAvailable();
    while(N~=0)
        fread(serPort,N);
        N = serPort.BytesAvailable();
    end
    
    fwrite(serPort, [142]);  fwrite(serPort,7);
    BmpWheDrps = dec2bin(fread(serPort, 1),8);
    BumpRight = bin2dec(BmpWheDrps(end));
    BumpLeft = bin2dec(BmpWheDrps(end-1));
    WheDropRight = bin2dec(BmpWheDrps(end-2));
    WheDropLeft = bin2dec(BmpWheDrps(end-3));
    BumpFront=(BumpRight*BumpLeft);
    if BumpFront==1
        BumpRight =0;
        BumpLeft =0;
    end
    
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end