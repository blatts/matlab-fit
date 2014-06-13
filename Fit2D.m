% -*- mode: Matlab -*-
% Time-stamp: "2014-06-13 15:45:31 sb"

%  file       Fit2D.m
%  copyright  (c) Sebastian Blatt 2011, 2012, 2013, 2014

function fitresult = Fit2D(data, model)
  % Convenience wrapper around 2D fits to DATA. MODEL is a string switching
  % between the different fit functions. This file aims to provide a
  % standardized interface to 2D peak fits and returns a struct with members
  %
  %   npars % number of fit parameters
  %   labels % cell array of parameter names
  %   description % string describing the functional form
  %   formula % string describing the mathematical formula in free-form
  %   parameters % vector of final parameter values
  %   errors % vector of final parameter error estimates
  %   cov % final covariance matrix (unscaled)
  %   volume % integrated volume under 2D surface
  %   amplitude % peak amplitude of surface without background
  %   center % [x,y] position of peak
  %   width % [x,y] "widths" of peak, function-dependent
  %   offset % background offset

  p = [];
  dp = [];
  labels = {};
  volume = 0;

  % Need this kludge, otherwise the inline functions will fail, since
  % INLINEEVAL is used and the 'private' subdirectory does not seem to be
  % accessible from the inline function.
  addpath(fullfile('matlab-fit', 'Fit_Functions'));

  switch model
   case 'Gauss2D'
    [p,dp,cov,res] = Fit_FitGauss2D(data);
    labels = {'z0','A','x0','xw','y0','yw','cor'};
    amplitude = p(2);
    damplitude = dp(2);
    volume = 2*pi*p(2)*sqrt(1-p(7)^2)*p(4)*p(6);
    dvolume = volume * sqrt( (dp(2)/p(2))^2 + (dp(4)/p(4))^2 + (dp(6)/p(6))^2 ...
                             + (dp(7) * p(7)/(1 - p(7)^2))^2);
    center = [p(3),p(5)];
    dcenter = [dp(3), dp(5)];
    width = [p(4),p(6)];
    dwidth = [dp(4), dp(6)];
    offset = p(1);
    doffset = dp(1);
    description = '2D Gaussian with rotation';
    formula = 'z0 + A exp( -1/(2(1-cor^2)) ( (x-x0)^2/xw^2 + (y-y0)^2/yw^2 - 2 cor (x-x0)(y-y0)/(xw yw) ) )';
   otherwise
    error('[FATAL:Fit2D] Model "%s" not implemented!',model);
  end

  fitresult.npars = length(labels);
  fitresult.labels = labels;
  fitresult.description = description;
  fitresult.formula = formula;
  fitresult.parameters = p;
  fitresult.errors = dp;
  fitresult.cov = cov;
  fitresult.residuals = res;
  fitresult.volume = [volume, dvolume];
  fitresult.amplitude = [amplitude, damplitude];
  fitresult.center = [center, dcenter];
  fitresult.width = [width, dwidth];
  fitresult.offset = [offset, doffset];
end
