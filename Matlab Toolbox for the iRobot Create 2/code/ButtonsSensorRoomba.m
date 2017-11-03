function [Clock, Schedule, Day, Hour, Minute, Dock, Spot, Clean] = ButtonsSensorRoomba(serPort)
% [Clock, Schedule, Day, Hour, Minute, Dock, Spot, Clean] = ButtonsSensorRoomba(serPort)
% Queries the state of Create's buttons.
% Clock, Schedule, Day, Hour, Minute, Dock, Spot, Clean are returned as pressed (1) or
% not pressed (0)
% serPort is a serial port object created by RoombaInit
% -----------
% Note that the Clock and Schedule buttons do not respond (0 always).
% By Joel Esposito, US Naval Academy, 2015

%initialize preliminary return values
Clock= nan; Schedule= nan; Day= nan; Hour= nan; Minute= nan; Dock= nan; Spot= nan; Clean= nan;
try
    %Flush Buffer
    N = serPort.BytesAvailable();
    while(N~=0)
        fread(serPort,N);
        N = serPort.BytesAvailable();
    end
    fwrite(serPort, [142]);  fwrite(serPort,18);
    
    Buttons = dec2bin(fread(serPort, 1),8);
    
    Clock = bin2dec(Buttons(end-7));
    Schedule = bin2dec(Buttons(end-6));
    Day = bin2dec(Buttons(end-5));
    Hour = bin2dec(Buttons(end-4));
    Minute = bin2dec(Buttons(end-3));
    Dock = bin2dec(Buttons(end-2));
    Spot = bin2dec(Buttons(end-1));
    Clean = bin2dec(Buttons(end));
    
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end