function SetWheelVelRoomba(serPort, rightWheelVel, leftWheelVel )
%  SetWheelVelRoomba(serPort, rightWheelVel, leftWheelVel )
%  Specify linear velocity of left wheel and right wheel
%  rightWheelVel, leftWheelVel are in meters/ sec
%  between [-0.5, 0.5].   Negative velocity is backward.
%  Velocities saturate if outside of acceptable range.
%  serPort is a serial port object created by RoombaInit.
%  By Joel Esposito, US Naval Academy, 2015

try    
    rightWheelVel = min( max(1000* rightWheelVel, -500) , 500);
    leftWheelVel = min( max(1000* leftWheelVel, -500) , 500);
    
    fwrite(serPort, [145]);  
    fwrite(serPort,rightWheelVel, 'int16'); 
    fwrite(serPort,leftWheelVel, 'int16');  
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end