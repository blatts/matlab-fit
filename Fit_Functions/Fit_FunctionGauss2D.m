% -*- mode: MATLAB -*-
% Time-stamp: "2011-09-21 18:22:25 sb"

%  file       Fit_FunctionGauss2D.m
%  copyright  (c) Sebastian Blatt 2009, 2010, 2011
%
%  This file is licensed under the Creative Commons Attribution 3.0
%  Unported License (see http://creativecommons.org/licenses/by/3.0).
%

function z = Fit_FunctionGauss2D(p,x,y)
  % Evaluate 2D gaussian for X,Y. 2d gaussian is defined as the function
  %
  %   f(x,y) = z0 + A exp( -1/(2(1-cor^2)) ( (x-x0)^2/xw^2 +
  %                       (y-y0)^2/yw^2 - 2 cor (x-x0)(y-y0)/(xw yw) ) )
  %
  % Parameter vector P is encoded as
  %
  %   P = [z0, A, x0, xw, y0, yw, cor]
  %
  dx = (x-p(3))./p(4);
  dy = (y-p(5))./p(6);
  xx = (dx.*dx)'*ones(size(dy));
  yy = ones(size(dx))'*(dy.*dy);
  xy = dx'*dy;
  A = xx + yy - 2*p(7)*xy;
  z = p(1) + p(2) * exp( A'/(-2*(1-p(7)^2)));
end
