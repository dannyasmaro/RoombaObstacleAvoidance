function SetLEDsRoomba(serPort,CheckRobotLEDstate,DockLEDstate, ...
    SpotLEDstate, DirtLEDstate,  PowerLEDColor, PowerLEDIntensity)
% SetLEDsRoomba(serPort,CheckRobotLEDstate,DockLEDstate,
%  SpotLEDstate, DebrisLEDstate,  PowerLEDColor, PowerLEDIntensity)
% Manipulates LEDS
% CheckRobotLEDstate,DockLEDstate, SpotLEDstate, and DirtLEDstate
% can be set as 1 (on) and 0 (off).
% CheckRobotLED isthe red exclamation mark on the top left of robot.
% DockLED and SpotLEDs are located under the buttons labeled as such.
% DirtLED is the blue LED located next to the words DirtDetect.
% The PowerLED's (center button) color and intensity can be controlled with finer
% resolution
% PowerLEDColor is 0 (pure green) to 100 (pure red). 
% PowerLEDIntensity is 0 (off) to 100 (brightest).  Values outside this
% range saturate.
% serPort is a serial port object created by Roombainit
% By Joel Esposito, US Naval Academy, 2015

L = bin2dec(strcat(num2str(CheckRobotLEDstate),num2str(DockLEDstate), ...
    num2str(SpotLEDstate), num2str(DirtLEDstate) ) );
pColor= min( max( round( (PowerLEDColor/100)*255 ), 0), 255);
pIntensity = min( max(round( (PowerLEDIntensity/100)*255 ), 0), 255);
fwrite(serPort, [139]);
fwrite(serPort,L);
fwrite(serPort,pColor);fwrite(serPort,pIntensity);
