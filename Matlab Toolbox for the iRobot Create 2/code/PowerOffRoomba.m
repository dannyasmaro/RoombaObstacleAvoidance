function PowerOffRoomba(serPort)
% PowerOffRoomba(serPort)
% Power down robot.  
% serPort is a serial port object created by RoombaInit
% Note that the physical power button does not work, and power saving and charging will not
% occur once the robot is initialized with RoombaInit.  There is a real
% risk of deeply discharging the Roomba's battery causing permanent
% damage.  Always use this command when done! 
% By Joel Esposito, US Naval Academy 2015
fwrite(serPort, [141 3]); % play RoombaInit song
pause(1);
fwrite(serPort, 133);
