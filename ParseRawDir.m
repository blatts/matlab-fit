% -*- mode: Matlab -*-
% Time-stamp: "2011-09-22 11:30:38 sb"

%  file       ParseRawDir.m
%  copyright  (c) Sebastian Blatt 2011

function info = ParseRawDir(directory)
  info = [];
  if ~isdir(directory)
    fprintf('[ERROR:ParseRawDir] "%s" is not a directory.\n',dir);
    return;
  end

  [rootDirectory,dirName,~] = fileparts(directory);
  regex = 'Raw-(?<shot>\d{4})';
  [pos,rc] = regexp(dirName, regex, 'tokens', 'names');
  if length(pos) == 0
    fprintf(['[ERROR:ParseRawDir] directory "%s" did not match RunDir ' ...
             'expression "%s".\n'], dirName, regex);
    return;
  end

  info = struct;
  info.root = rootDirectory;
  info.directory = dirName;
  info.shot_number = str2num(rc.shot);

  info.tiff_files = {};
  files = dir(fullfile(info.root, info.directory, '*.tif'));
  for i=1:length(files)
    info.tiff_files{i} = files(i).name;
  end

end
