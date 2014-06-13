% -*- mode: MATLAB -*-
% Time-stamp: "2014-06-13 11:13:56 sb"

%  file       Fit_FunctionGauss1D.m
%  copyright  (c) Sebastian Blatt 2009 -- 2014
%
%  This file is licensed under the Creative Commons Attribution 3.0
%  Unported License (see http://creativecommons.org/licenses/by/3.0).
%

function y = Fit_FunctionGauss1D(p,x)
  % Evaluate 1D gaussian for X. 1d gaussian is defined as the function
  %
  %   f(x) = z0 + A exp( - (x-x0)^2 / (2 xw^2))
  %
  % Parameter vector P is encoded as
  %
  %   P = [z0, A, x0, xw]
  %
  dx = (x-p(3))./(p(4));
  y = p(1) + p(2) * exp(-dx.*dx/2.0);
end
