function SetPWMRoomba(serPort, LeftPWM, RightPWM)
% setPWM(serPort, LeftPWM, RightPWM)
% provides direct control over wheel actuator's pulsewidth modulation
% driver.
% LeftPWM and RightPWM are values ranging from 100 (full speed forward) to
% -100 (full speed backward).  Values outside this range are saturated.
% serPort is a serial port object created by RoombaInit
% By Joel Esposito, US Naval Academy 2015

L = max(min( 255, round(LeftPWM/100 * 255) ), -255);
R = max(min( 255, round(RightPWM/100 * 255) ), -255);
fwrite(serPort, [146]);
fwrite(serPort,R, 'int16');
fwrite(serPort,L, 'int16');


