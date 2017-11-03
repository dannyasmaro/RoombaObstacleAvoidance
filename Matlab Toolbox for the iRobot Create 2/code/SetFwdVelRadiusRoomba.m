function SetFwdVelRadiusRoomba(serPort, FwdVel, Radius)
%  SetFwdVelRadiusRoomba(serPort, FwdVel, Radius)
%  Moves Roomba by setting forward vel and turn radius
%  FwdVel is forward vel in m/sec [-0.5, 0.5],
%  Radius in meters, when driving forward postive turns left, negative turns right [-2,2]
%  Special cases: Straight = inf
%  Turn in place clockwise = -eps
%  Turn in place counter-clockwise = eps
%  serPort is a serial port object created by Roombainit
%  By Joel Esposito, US Naval Academy, 2015
try
    % Convert to millimeters
    FwdVelMM = min( max(FwdVel,-.5), .5)*1000;
    if isinf(Radius)
        RadiusMM = 32768;
    elseif Radius == eps
        RadiusMM = 1;
    elseif Radius == -eps
        RadiusMM = -1;
    else
        RadiusMM = min( max(Radius*1000,-2000), 2000);
    end
    
    fwrite(serPort, [137]);  fwrite(serPort,FwdVelMM, 'int16'); fwrite(serPort,RadiusMM, 'int16');
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end

