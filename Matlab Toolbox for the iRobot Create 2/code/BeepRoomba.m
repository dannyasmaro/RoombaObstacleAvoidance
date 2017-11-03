function [] = BeepRoomba(serPort)
% BeepRoomba(serPort)
% Plays a short beep.
% The tone and duration are hardcoded inside of RoombaInit
% serPort is a serial port object created by RoombaInit
% By Joel Esposito, US Naval Academy, 2015

fwrite(serPort, [141 2])
