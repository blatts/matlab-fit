% -*- mode: MATLAB -*-
% Time-stamp: "2011-09-26 13:57:55 sb"

%  file       BlastiaImageStatistics.m
%  copyright  (c) Sebastian Blatt 2009, 2010, 2011
%
%  This file is licensed under the Creative Commons Attribution 3.0
%  Unported License (see http://creativecommons.org/licenses/by/3.0).
%

function s = BlastiaImageStatistics(img)
  % Evaluate stastistics for image IMG and return vector S:
  %
  %   S = [min, median, mean, max, integrated, comx, comy, varx, vary];

  [width,height] = size(img);

  % moments
  m1 = 0;
  c = [0,0];
  for i=1:width,
    for j=1:height,
      z = double(max(0, img(i,j)));
      m1 = m1 + z;
      c = c + [i,j] * z;
    end
  end

  % integrated amplitude
  intamp = m1;
  % mean amplitude
  meanamp = m1 / (width*height);
  % median amplitude
  medamp = median(median(img));

  % center of mass
  cx = c(1)/m1;
  cy = c(2)/m1;

  % maximum and minimum
  mx = max(max(img));
  mn = min(min(img));

  % column and row variance at center of mass
  comx = floor(cx+0.5);
  comy = floor(cy+0.5);
  zx = double(img(:,comy));
  m2x = sum(((1:width)' - comx).^2 .* zx)/sum(zx);
  zy = double(img(comx,:));
  m2y = sum(((1:height) - comy).^2 .* zy)/sum(zy);

  s = [mn, medamp, meanamp, mx, intamp, cx, cy, sqrt(m2x), sqrt(m2y)];
end
