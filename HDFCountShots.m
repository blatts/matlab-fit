% -*- mode: Matlab -*-
% Time-stamp: "2013-07-13 16:38:21 sb"

%  file       HDFCountShots.m
%  copyright  (c) Sebastian Blatt 2013

function number_of_shots = HDFCountShots(file)
  number_of_shots = 0;

  fid = H5F.open(file);
  gid = H5G.open(fid, '/');

  info = H5G.get_info(gid);
  number_of_shots = info.nlinks;

  H5G.close(gid);
  H5F.close(fid);
