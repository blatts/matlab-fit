% -*- mode: Matlab -*-
% Time-stamp: "2014-06-10 14:15:43 sb"

%  file       MakeAbsorptionImage.m
%  copyright  (c) Sebastian Blatt 2011, 2012, 2013, 2014

function imageOd = MakeAbsorptionImage(imageinfo)
  imageOd = [];
  if ~isstruct(imageinfo) || isempty(fieldnames(imageinfo))
    fprintf('[ERROR:MakeAbsorptionImage] Need imageinfo struct.\n');
    return;
  end

  if imageinfo.nframes < 3
    fprintf('[ERROR:MakeAbsorptionImage] Need 3 or more frames\n');
    return;
  end

  frame_offset = 0;
  if imageinfo.nframes > 3
    frame_offset = 1;
  end

  ImageDiffThreshold = 0.1;

  % shadow - dark (= atoms - background)
  img_a = max(double(imageinfo.frames{1+frame_offset})-double(imageinfo.frames{3+frame_offset}), ImageDiffThreshold);
  % light - dark (= laser - background)
  img_b = max(double(imageinfo.frames{2+frame_offset})-double(imageinfo.frames{3+frame_offset}), ImageDiffThreshold);

  % Check for bad pixels
  NBadPixels1 = sum(sum((img_a == ImageDiffThreshold)));
  NBadPixels2 = sum(sum((img_b == ImageDiffThreshold)));
  if NBadPixels1 > 0,
    fprintf(['[WARNING:MakeAbsorptionImage] Difference image %d - %d has ' ...
    '%d negative pixels.\n'], 1+frame_offset, 3+frame_offset, NBadPixels1);
  end
  if NBadPixels2 > 0,
    fprintf(['[WARNING:MakeAbsorptionImage] Difference image %d - %d has ' ...
    '%d negative pixels.\n'], 2+frame_offset, 3+frame_offset, NBadPixels2);
  end

  % Calculate OD image and limit its range to ImageODMinMax
  ImageODMinMax = [-1, 10];
  %ImageODMinMax = [0, 10];
  imageOd = min(max(-reallog(img_a)+reallog(img_b), ...
                    ImageODMinMax(1)), ImageODMinMax(2));
  NBadODPixels = sum(sum(imageOd == ImageODMinMax(1) | ...
                         imageOd == ImageODMinMax(2) ));
  if NBadODPixels > 0,
    fprintf('[WARNING:MakeAbsorptionImage] OD image has %d pixels out of range [%g, %g].\n',...
            NBadODPixels,ImageODMinMax(1),ImageODMinMax(2));
  end

end
