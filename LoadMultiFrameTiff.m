% -*- mode: Matlab -*-
% Time-stamp: "2011-09-22 11:46:37 sb"

%  file       LoadMultiFrameTiff.m
%  copyright  (c) Sebastian Blatt 2011

function imageinfo = LoadMultiFrameTiff(filename),
  info = imfinfo(filename);

  imageinfo = struct;
  imageinfo.file = filename;
  imageinfo.nframes = length(info);
  imageinfo.width = info(1).Width;
  imageinfo.height = info(1).Height;
  imageinfo.frames = {};
  for i=1:imageinfo.nframes
    imageinfo.frames{i} = imread(filename,'Index',i);
  end
end
