% -*- mode: MATLAB -*-
% Time-stamp: "2014-06-13 12:45:01 sb"

%  file       Fit_VectorStatisticsXY.m
%  copyright  (c) Sebastian Blatt 2009 -- 2014
%
%  This file is licensed under the Creative Commons Attribution 3.0
%  Unported License (see http://creativecommons.org/licenses/by/3.0).
%


function s = Fit_VectorStatisticsXY(x, y)
  % Evaluate stastistics for vector Y defined over X and return vector S:
  %
  %   S = [min, median, mean, max, integrated, com, var];

  width = length(y);

  % moments
  m1 = sum(y);

  % integrated amplitude
  intamp = m1;
  % mean amplitude
  meanamp = m1 / (width);
  % median amplitude
  medamp = median(y);

  % center of mass
  cx = sum(x.*y)/m1;

  % maximum and minimum
  mx = max(y);
  mn = min(y);

  % column and row variance at center of mass
  comx = floor(cx+0.5);
  m2x = sum((x - comx).^2 .* y)/m1;

  s = [mn, medamp, meanamp, mx, intamp, cx, sqrt(m2x)];
end
