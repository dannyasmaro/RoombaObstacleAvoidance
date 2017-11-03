function SeekDockRoomba(serPort)
% SeekDockRoomba(serPort)
% Make robot drive to dock and recharge the next time it encounters the docking beams.  
% serPort is a serial port object created with RoombaInit
% Note this commands sets robot to 'Passive Mode'
% which means you can request sensor infor but not send actuator commands.
% Return to Full or Safe mode using RoombaInit
% By Joel Esposito, US Naval Academy 2015

fwrite(serPort, 143);
