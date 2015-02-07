function out = ellipse(x,y,theta,a,b)
% plot_ellipse(x,y,theta,a,b)
% Util function that returns points 
if nargin<5, error('Too few arguments to Plot_Ellipse.'); end;

% number of steps used in plotting this ellipse (aka resolution)
np = 100;

% angle of the current point
ang = [0:np]*2*pi/np;


% this line becomes a bunch of mean points
pts = [x;y]*ones(size(ang)) + ...
    [cos(theta) -sin(theta); sin(theta) cos(theta)]*[cos(ang)*a; sin(ang)*b];
% plus a transformation matrix times the 
% cos(theta)*x-radius or sin(theta)*y-radius bits of an ellipse.

out = pts;