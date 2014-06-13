% -*- mode: Matlab -*-
% Time-stamp: "2013-07-13 19:18:38 sb"

%  file       ParseBaseDir.m
%  copyright  (c) Sebastian Blatt 2013

function info = ParseBaseDir(directory)
  info = [];
  if ~isdir(directory)
    fprintf('[ERROR:ParseBaseDir] "%s" is not a directory.\n',dir);
    return;
  end

  info = struct;
  info.directory = directory;

  info.rundirs = {};
  files = dir(fullfile(info.directory, '*'));
  j = 1;
  for i=1:length(files)
    n = files(i).name;
    if strcmp(n, '.') == 1 || strcmp(n, '..') == 1
      continue;
    end
    fn = fullfile(info.directory, files(i).name);
    if isdir(fn),
      info.rundirs{j} = files(i).name;
      j = j + 1;
    end
  end
end
