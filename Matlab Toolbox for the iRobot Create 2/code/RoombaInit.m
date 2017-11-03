function [serPort] = RoombaInit(varargin)
% RombaInit
% Initializes the serial connection to robot.  Two ways to call:
% [serPort] = RoombaInit(my_COM)
% [serPort] = RoombaInit(my_COM, mode)
% -----------------------
% [serPort] = RoombaInit(my_COM)
% Initializes serial port and Roomba
% my_COM is the number of the comm port
% ex. RoombaInit(1) sets port = 'COM1'
% Uses baudrate default of 115200
% When only one input argument is used, the robot is set to "safe mode" (won't run if plugged in,
% wheel drops or cliff sensor activated).  When one of these conditions is
% triggered the robot switches to 'passive mode' in which all actuators are
% disabled.   In order to regain control of the robot, it must be reset with
% RoombaInit.
% serPort is a serial port object which must be passed to all other Roomba
% or Create commands
% ---------------------------
% [serPort] = RoombaInit(my_COM, mode)
% mode = 'safe' puts the Create in Safe mode
% mode = 'full' puts the Create in Full mode which disables those safety
% features.
% By Joel Esposito, US Naval Academy, 2015

if nargin ==0 || ~isfloat(varargin{1}) || (varargin{1} - round(varargin{1}) ~=0)
    error('First input argument must be an integer specifing the comm port.')
end


if (nargin ==1) || strcmp( varargin{2}, 'safe')
    Mode = 131;
elseif (nargin == 2) && strcmp( varargin{2}, 'full')
    Mode = 132;
elseif (nargin == 2) && ~strcmp( varargin{2}, 'full') && (nargin == 2) && ~strcmp( varargin{2}, 'safe')
    error('Unknow second argument.  Only mode options are safe and full')
end

%% set up serial comms,
% output buffer must be big enough to take largest message size
comm = strcat('COM', num2str(varargin{1}));

instrreset
a = instrfind('port',comm);
if ~isempty(a)
    disp('That com port is in use.   Closing it.')
    fclose(a);
    pause(.5)
    delete(a);
    pause(.5)
end

disp('Establishing connection to Roomba...');

% defaults at 115200, can change (see API)
serPort = serial(comm,'BaudRate', 115200);
set(serPort,'Terminator','LF')
set(serPort,'InputBufferSize',1000)
set(serPort, 'Timeout', .5)
set(serPort, 'ByteOrder','bigEndian');

fopen(serPort);

%% mode
if Mode == 132
    fprintf('Setting Roomba to FULL Mode...')
    set(serPort, 'Tag', 'full')
else
    fprintf('Setting Roomba to SAFE Mode...')
    set(serPort, 'Tag', 'safe')
end
% Start!
Start=[128];
fwrite(serPort,Start);
pause(.1)

fwrite(serPort,Mode);
pause(.1)

% %Print 'go' on display
fwrite(serPort, [164, 71, 79, 32, 32]);
% make a sound
fwrite(serPort, [140 1 3 60 20 72 20 84 40 ]); %RoombaInit Song
fwrite(serPort, [140 2 1 60 20]); % BeepRoomba song
fwrite(serPort, [140 3 3 84 20 72 30 60 40]); % PowerOffRoomba song
fwrite(serPort, [141 1]); % play RoombaInit song
disp('Robot should display go on 7 segment LED panel and play song.')
pause(1);