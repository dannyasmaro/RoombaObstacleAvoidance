function Firmware = GetFirmwareRoomba(PortNumber)
% Firmware =  GetFirmwareRoomba(serPort)
% This function can be used to detect the version of the firmware on the robot.
% It requires the use of a Phillips head screw driver.  Step through instruction are provided within.
% You will need to use RoombaInit when done.
% portNumber is an integer specifying the comport
% Firmware is a string specifying the firmware version.  The toolbox was
% developed on version 3.2.3.   There are some known bugs in the Create
% Open Interface prior to version 3.3.0.
% by Joel M. Esposito, US Naval Academy, 2015

%% set up serial comms,
% output buffer must be big enough to take largest message size
clc
Firmware = nan;
disp('Preparing to check firmware version...');
comm = strcat('COM', num2str(PortNumber));

instrreset
a = instrfind('port',comm);
if ~isempty(a)
    disp('Reestablishing communication with robot...')
    fclose(a);
    pause(.5)
    delete(a);
    pause(.5)
end


% defaults at 115200, can change (see API)
serPort = serial(comm,'BaudRate', 115200);
set(serPort,'Terminator','LF')
set(serPort,'InputBufferSize',1000)
set(serPort, 'Timeout', .5)
set(serPort, 'ByteOrder','bigEndian');

fopen(serPort);

 %Flush Buffer
    N = serPort.BytesAvailable();
    while(N~=0)
        fread(serPort,N);
        N = serPort.BytesAvailable();
    end
    
beep;
disp('------------------------')
disp('You must reset the robot to get firmware.  Instructions:')
disp('1. Turn robot upside down, leaving communication cable in place.')
disp('2. Using a small Phillips head screwdriver, remove the four large screws on the bottom cover.')
disp('3. Remove the battery and replace it.  You should hear a series of short ascending notes.')
disp(' PRESS ANY KEY WHEN DONE')
disp('------------------------')
pause()
pause(1)
warning off
StartUpMessage = char( fread(serPort) )'
warning on
disp('------------------------')
try
    T = strfind(StartUpMessage, 'release-');
    s = StartUpMessage(T+8:end);
    P = strfind(s, ':');
    disp('I beleive your firmware is:') 
    Firmware = s(1:P(1)-1)
catch
    beep
    warning('Cannot detect firmware automatically, look for the release information in the start up message above or check port number and try resetting again.')
end
disp(' Replace battery cover and screws when done, then reinitialize with RoombaInit.')