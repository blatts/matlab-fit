% -*- mode: Matlab -*-
% Time-stamp: "2011-09-22 11:30:28 sb"

%  file       ParseRunDir.m
%  copyright  (c) Sebastian Blatt 2011

function info = ParseRunDir(directory)
  info = [];
  if ~isdir(directory)
    fprintf('[ERROR:ParseRunDir] "%s" is not a directory.\n',dir);
    return;
  end

  [rootDirectory,dirName,~] = fileparts(directory);
  regex = '(?<year>\d{4})(?<month>\d{2})(?<day>\d{2})-(?<run>\d{4})';
  [pos,rc] = regexp(dirName, regex, 'tokens', 'names');
  if length(pos) == 0
    fprintf(['[ERROR:ParseRunDir] directory "%s" did not match RunDir ' ...
             'expression "%s".\n'], dirName, regex);
    return;
  end

  info = struct;
  info.root = rootDirectory;
  info.directory = dirName;
  info.year = str2num(rc.year);
  info.month = str2num(rc.month);
  info.day = str2num(rc.day);
  info.run_number = str2num(rc.run);

  info.raw_subdirectories = {};
  dirs = dir(fullfile(info.root,info.directory,'Raw-*'));
  k=1;
  for i=1:length(dirs)
    p = fullfile(info.root,info.directory,dirs(i).name);
    if isdir(p)
      info.raw_subdirectories{k} = dirs(i).name;
      k = k+1;
    end
  end

end
