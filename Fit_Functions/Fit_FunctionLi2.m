% -*- mode: MATLAB -*-
% Time-stamp: "2014-06-13 12:56:14 sb"

%  file       Fit_FunctionLi2.m
%  copyright  (c) Sebastian Blatt 2009 -- 2014
%
%  This file is licensed under the Creative Commons Attribution 3.0
%  Unported License (see http://creativecommons.org/licenses/by/3.0).
%

function y = Fit_FunctionLi2(p,x)
  % Evaluate radial polylogarithm for Fermi gas fits, see Zwierlein review
  %
  %   f(x) = y0 + A Li_2( -exp(ln(z) - (x/x0)^2 g(z)) ) / Li_2(-z)
  %   g(z) = (1 + z)/z ln(1+z)
  %   z = 10^c
  %
  % Parameter vector P is encoded as
  %
  %   P = [y0, A, x0, c]
  %
  dx = (x/p(3));
  z = 10^p(4);
  g = (1 + z) / z * log(1+z);
  y = p(1) + p(2) * dilog(-exp(log(z) - g * dx.*dx)) / dilog(-z);
end
