% -*- mode: MATLAB -*-
% Time-stamp: "2011-09-21 18:24:17 sb"

%  file       Fit_VectorStatistics.m
%  copyright  (c) Sebastian Blatt 2009, 2010, 2011
%
%  This file is licensed under the Creative Commons Attribution 3.0
%  Unported License (see http://creativecommons.org/licenses/by/3.0).
%


function s = Fit_VectorStatistics(v)
  % Evaluate stastistics for vector V and return vector S:
  %
  %   S = [min, median, mean, max, integrated, com, var];

  width = length(v);

  % moments
  m1 = sum(v);

  % integrated amplitude
  intamp = m1;
  % mean amplitude
  meanamp = m1 / (width);
  % median amplitude
  medamp = median(v);

  % center of mass
  cx = sum((1:width).*v)/m1;

  % maximum and minimum
  mx = max(v);
  mn = min(v);

  % column and row variance at center of mass
  comx = floor(cx+0.5);
  m2x = sum(((1:width) - comx).^2 .* v)/m1;

  s = [mn, medamp, meanamp, mx, intamp, cx, sqrt(m2x)];
end
