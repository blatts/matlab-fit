% -*- mode: MATLAB -*-
% Time-stamp: "2014-06-13 12:38:28 sb"

%  file       Fit_FitGauss1D.m
%  copyright  (c) Sebastian Blatt 2009 -- 2014
%
%  This file is licensed under the Creative Commons Attribution 3.0
%  Unported License (see http://creativecommons.org/licenses/by/3.0).
%

function [p,dp,cov,res] = Fit_FitGauss1D(xdata, ydata, yerrs)
  % Fit a 1D Gaussian to vectors XDATA, YDATA and return parameter vector P
  % with errors DP.

  dim = length(ydata);
  lb = [-10, 0, 0, 1];
  ub = [10, 100, dim, 2*dim];
  s = Fit_VectorStatistics(ydata);
  %fprintf('Vector statistics:\n');
  %fprintf('  Min, Max        : %f, %f\n',s(1),s(4));
  %fprintf('  Median, Mean    : %f, %f\n',s(2),s(3));
  %fprintf('  Integrated      : %f\n',s(5));
  %fprintf('  Center of Mass  : %f\n',s(6));
  %fprintf('  Variance at COM : %f\n',s(7));
  %fprintf('  Amplitude at COM: %f\n',data(floor(s(6)+.5)));
  p0 = [s(2), s(4)-s(2), s(6), s(7)];
  f = inline('Fit_FunctionGauss1D(p,x)','p','x');
  [p, dp, cov, res] = Fit_DoFit1D(xdata, ydata, yerrs, lb, ub, f, p0);
end
