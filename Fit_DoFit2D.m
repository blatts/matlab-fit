% -*- mode: MATLAB -*-
% Time-stamp: "2013-07-13 18:59:20 sb"

%  file       Fit_DoFit2D.m
%  copyright  (c) Sebastian Blatt 2009 -- 2013
%
%  This file is licensed under the Creative Commons Attribution 3.0
%  Unported License (see http://creativecommons.org/licenses/by/3.0).
%

function [p,dp,cov,res] = Fit_DoFit2D(data,e,lb,ub,f,p0)
  % Return best fit parameters P and standard errors DP for fitting F to
  % two-dimensional data (matrix) DATA with error matrix E using start
  % parameters P0 and bounds LB and UB to limit the result. The procedure
  % uses Matlab's LSQNONLIN and the Levenberg-Marquardt algorithm.


  %opts = optimset('LevenbergMarquardt','on','MaxFunEvals',10000, ...
  %                'MaxIter',1000);
  % On MATLAB R2012B, this changed to trust-region-reflective, since
  % L-M does not handle bounds?
  opts = optimset('Algorithm', 'trust-region-reflective','MaxFunEvals',10000, ...
                  'MaxIter',1000);

  fit_func = inline('(data-f(p,x,y))./e','p','x','y','data','e','f');
  dim = size(data);
  x = linspace(0,dim(2)-1,dim(2));
  y = linspace(0,dim(1)-1,dim(1));

  tic
  [p , ~, res , ~, ~, ~, J] = lsqnonlin(fit_func,p0,lb,ub,opts,x,y,data,e,f);
  toc

  [dp,cov] = Fit_JacobianToCI(J,res);
end
