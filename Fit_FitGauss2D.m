% -*- mode: Matlab -*-
% Time-stamp: "2011-09-26 14:14:24 sb"

%  file       Fit_FitGauss2D.m
%  copyright  (c) Sebastian Blatt 2011

%
%  This file is licensed under the Creative Commons Attribution 3.0
%  Unported License (see http://creativecommons.org/licenses/by/3.0).
%

function [p,dp,cov,res] = Fit_FitGauss2D(data)
  % Fit a 2D Gaussian to image DATA and return parameter vector P with
  % errors DP.
  %  e = sqrt(data);
  e = ones(size(data));
  dim = size(data);
  s = BlastiaImageStatistics(data);
%   fprintf('Image statistics:\n');
%   fprintf('  Min, Max        : %f, %f\n',s(1),s(4));
%   fprintf('  Median, Mean    : %f, %f\n',s(2),s(3));
%   fprintf('  Integrated      : %f\n',s(5));
%   fprintf('  Center of Mass  : (%f,%f)\n',s(7),s(6));
%   fprintf('  Variance at COM : (%f,%f)\n',s(9),s(8));
%   fprintf('  Amplitude at COM: %f\n',data(floor(s(6)+.5),floor(s(7)+.5)));
  lb = [-1, 0, 0, 1, 0, 1, -10];
  p0 = [s(2), s(4)-s(2), s(7), s(9), s(6), s(8), 0];
  ub = [s(4), s(4), dim(2), 2*dim(2), dim(1), 2*dim(1), 10];
  f = inline('Fit_FunctionGauss2D(p,x,y)','p','x','y');
  [p, dp, cov, res] = Fit_DoFit2D(data,e,lb,ub,f,p0);
end
