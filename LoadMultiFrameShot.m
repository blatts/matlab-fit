% -*- mode: Matlab -*-
% Time-stamp: "2014-06-10 12:53:25 sb"

%  file       LoadMultiFrameShot.m
%  copyright  (c) Sebastian Blatt 2011, 2012, 2013, 2014

function imageinfo = LoadMultiFrameShot(filename, shotname)

  %camera = 'cameras_fleaGe0';
  %camera = 'IXon';
  camera = 'IStar';
  imagegroup = sprintf('/%s/Cameras/%s', shotname, camera);
  info = h5info(filename, imagegroup);

  imageinfo = struct;
  imageinfo.file = filename;
  imageinfo.shot = shotname;
  imageinfo.imagegroup = imagegroup;
  imageinfo.nframes = length(info.Datasets);

  imageinfo.framenames = {};
  imageinfo.frames = {};
  for i = 1:imageinfo.nframes
    imageinfo.framenames{i} = info.Datasets(i).Name;
    s = sprintf('%s/%s', imagegroup, imageinfo.framenames{i});
    imageinfo.frames{i} = h5read(filename, s)';
  end

  sz = size(imageinfo.frames{1});
  imageinfo.width = sz(2);
  imageinfo.height = sz(1);
