function [Charge, Capacity, Percent] = BatteryChargeReaderRoomba(serPort)
% [Charge, Capacity, Percent] = BatteryChargeReaderRoomba(serPort)
% Displays the current percent charge remaining in Create's Battery
% Charge is the current battery charge in milli-amp hours
% Capacity is the Roomba's battery capacity in milli-amp hours
% Percent (0 to 100) is Charge / Capacity * 100
% serPort is a serial port object created by RoombaInit.
% By Joel Esposito, US Naval Academy, 2015

%Initialize preliminary return values
Charge = nan;
Capacity = nan;
Percent = nan;

try
    %Flush Buffer
    N = serPort.BytesAvailable();
    while(N~=0)
        fread(serPort,N);
        N = serPort.BytesAvailable();
    end
  
    fwrite(serPort, [142]);  fwrite(serPort,25);
    Charge =  fread(serPort, 1, 'uint16');
    fwrite(serPort, [142]);  fwrite(serPort,26);
    Capacity =  fread(serPort, 1, 'uint16');
    Percent=Charge/Capacity*100;
    
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end
