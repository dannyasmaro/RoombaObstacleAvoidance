function SetFwdVelAngVelRoomba(serPort, FwdVel, AngVel )
%  SetFwdVelAngVelRoomba(serPort, FwdVel, AngVel )
%  Sets forward and angulkar velocity.
%  FwdVel forward velocity in meters/ sec [-0.5, 0.5].   
%  AngVel Angular Velocity in rad/sec.  Negative velocity is backward/Clockwise.  
%  serPort is a serial port object created by RoombaInit.
%  Note that the individual wheel speeds are capped at 0.5 meters per second, so it is possible to
%  specify robot velocities that cannot be achieved in which case a warning is displayed.
%  By Joel Esposito, US Naval Academy, 2015

try
    d = .235; % wheel baseline
    wheelVel = inv([.5 .5; 1/d -1/d])*[FwdVel; AngVel];
    rightWheelVel = min( max(1000* wheelVel(1), -500) , 500);
    leftWheelVel = min( max(1000* wheelVel(2), -500) , 500);
    if ( abs(rightWheelVel) ==500) ||  ( abs(leftWheelVel) ==500)
        disp('Warning: desired velocity combination exceeds wheel speed limits.')
    end
    fwrite(serPort, [145]);  fwrite(serPort,rightWheelVel, 'int16'); fwrite(serPort,leftWheelVel, 'int16');
    
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end