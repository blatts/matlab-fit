% -*- mode: Matlab -*-
% Time-stamp: "2014-06-13 15:45:24 sb"

%  file       Fit1D.m
%  copyright  (c) Sebastian Blatt 2011, 2012, 2013, 2014

function fitresult = Fit1D(data, model),
  % Convenience wrapper around 1D fits to DATA. MODEL is a string switching
  % between the different fit functions. This file aims to provide a
  % standardized interface to 1D peak fits and returns a struct with members
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

  % Allow data to be a simple vector of y-values (assumes x-values =
  % 1:length(data), or use a matrix of two rows, where the first (second)
  % row is the x (y) data, or three rows where the last one are the y
  % errors.
  sz = size(data);
  xdata = [];
  ydata = [];
  yerrs = [];
  if sz(1) == 1
    xdata = 1:sz(2);
    ydata = data;
    yerrs = ones(size(ydata));
  elseif sz(1) == 2;
    xdata = data(1, :);
    ydata = data(2, :);
    yerrs = ones(size(ydata));
  else
    xdata = data(1, :);
    ydata = data(2, :);
    yerrs = data(3, :);
  end


  switch model
   case 'Gauss'
    [p,dp,cov,res] = Fit_FitGauss1D(xdata, ydata, yerrs);
    labels = {'y0','A','x0','xw'};
    amplitude = p(2);
    damplitude = dp(2);
    area = sqrt(2*pi)*p(2)*p(4);
    darea = area * sqrt((dp(2)/p(2))^2 + (dp(4)/p(4))^2);;
    center = p(3);
    dcenter = dp(3);
    width = p(4);
    dwidth = dp(4);
    offset = p(1);
    doffset = dp(1);
    description = '1D Gaussian with offset';
    formula = 'y0 + A exp( - (x-x0)^2/ (2 xw^2))';

   case 'Li2'
    [p,dp,cov,res] = Fit_FitLi2(xdata, ydata, yerrs);
    labels = {'y0','A','x0','z'};
    amplitude = p(2);
    damplitude = dp(2);
    area = 0;
    darea = 0;
    center = 0;
    dcenter = 0;
    width = p(3);
    dwidth = dp(3);
    offset = p(1);
    doffset = dp(1);
    description = '1D Li_2 for radially averaged Fermi gas densities';
    formula = 'y0 + A Li_2( -exp(ln(z) - (x/x0)^2 g(z)) ) / Li_2(-z), g(z) = (1 + z)/z ln(1+z)';

   otherwise
    error('[FATAL:Fit1D] Model "%s" not implemented!',model);
  end

  fitresult = struct;
  fitresult.npars = length(labels);
  fitresult.labels = labels;
  fitresult.description = description;
  fitresult.formula = formula;
  fitresult.parameters = p;
  fitresult.errors = dp;
  fitresult.cov = cov;
  fitresult.residuals = res;
  fitresult.area = [area, darea];
  fitresult.amplitude = [amplitude, damplitude];
  fitresult.center = [center, dcenter];
  fitresult.width = [width, dwidth];
  fitresult.offset = [offset, doffset];
end
