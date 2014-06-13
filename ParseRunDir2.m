% -*- mode: Matlab -*-
% Time-stamp: "2013-07-13 18:41:49 sb"

%  file       ParseRunDir2.m
%  copyright  (c) Sebastian Blatt 2011, 2012, 2013

function info = ParseRunDir2(directory)
  info = [];
  if ~isdir(directory)
    fprintf('[ERROR:ParseRunDir2] "%s" is not a directory.\n',dir);
    return;
  end

  [rootDirectory,dirName,~] = fileparts(directory);
  regex = '(?<year>\d{4})(?<month>\d{2})(?<day>\d{2})-(?<run>\d{4})';
  [pos,rc] = regexp(dirName, regex, 'tokens', 'names');
  if length(pos) == 0
    fprintf(['[ERROR:ParseRunDir2] directory "%s" did not match RunDir ' ...
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

  s = sprintf('Scan-%04d%02d%02d-%04d.hdf', info.year, info.month, ...
              info.day, info.run_number);
  scanfile = fullfile(info.root, info.directory, s);

  info.scanfile = scanfile;
  info.shots = HDFGetShotNames(scanfile);

end
