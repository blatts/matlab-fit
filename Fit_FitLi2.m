% -*- mode: MATLAB -*-
% Time-stamp: "2014-06-13 12:58:40 sb"

%  file       Fit_FitLi2.m
%  copyright  (c) Sebastian Blatt 2009 -- 2014
%
%  This file is licensed under the Creative Commons Attribution 3.0
%  Unported License (see http://creativecommons.org/licenses/by/3.0).
%

function [p,dp,cov,res] = Fit_FitLi2(xdata, ydata, yerrs)
  % Fit a Li_2 based function for Fermi densitiies to vector XDATA, YDATA and
  % return parameter vector P with errors DP.

  dim = length(ydata);
  s = Fit_VectorStatisticsXY(xdata, ydata);
  % fprintf('Vector statistics:\n');
  % fprintf('  Min, Max        : %f, %f\n',s(1),s(4));
  % fprintf('  Median, Mean    : %f, %f\n',s(2),s(3));
  % fprintf('  Integrated      : %f\n',s(5));
  % fprintf('  Center of Mass  : %f\n',s(6));
  % fprintf('  Variance at COM : %f\n',s(7));
  %fprintf('  Amplitude at COM: %f\n',ydata(floor(s(6)+.5)));

  %lb = [s(1), s(4), 0, 0];
  %ub = [s(4), 2*s(4), max(xdata), 10];
  lb = [];
  ub = [];
  p0 = [s(1), s(4)-s(1), s(7), 1e-5];
  f = inline('Fit_FunctionLi2(p,x)','p','x');
  [p, dp, cov, res] = Fit_DoFit1D(xdata, ydata, yerrs, lb, ub, f, p0);
end
