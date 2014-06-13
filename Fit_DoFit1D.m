% -*- mode: MATLAB -*-
% Time-stamp: "2014-06-13 12:42:41 sb"

%  file       Fit_DoFit1D.m
%  copyright  (c) Sebastian Blatt 2009 -- 2014
%
%  This file is licensed under the Creative Commons Attribution 3.0
%  Unported License (see http://creativecommons.org/licenses/by/3.0).


function [p, dp, cov, res] = Fit_DoFit1D(xdata, ydata, yerrs, lb, ub, f, p0)
% Return best fit parameters P and standard errors DP for fitting F to
% one-dimensional data vectors XDATA, YDATA with error vector YERRS using
% start parameters P0 and bounds LB and UB to limit the result. The
% procedure uses Matlab's LSQNONLIN and the Levenberg-Marquardt algorithm.


  %opts = optimset('LevenbergMarquardt','on','MaxFunEvals',10000, ...
  %                'MaxIter',1000);
  % On MATLAB R2012B, this changed to trust-region-reflective, since
  % L-M does not handle bounds?
  opts = optimset('Algorithm', 'trust-region-reflective','MaxFunEvals',10000, ...
                  'MaxIter',1000);

  fit_func = inline('(ydata-f(p,xdata))./yerrs', 'p', 'xdata', 'ydata', 'yerrs', 'f');

  tic

  [p nrm res efl out lmd J] = lsqnonlin(fit_func, p0, lb, ub, opts, ...
                                        xdata, ydata, yerrs, f);

  toc
  [dp, cov] = Fit_JacobianToCI(J, res);
end
