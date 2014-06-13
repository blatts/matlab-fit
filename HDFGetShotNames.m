% -*- mode: Matlab -*-
% Time-stamp: "2013-07-13 18:10:08 sb"

%  file       HDFGetShotNames.m
%  copyright  (c) Sebastian Blatt 2013

function shot_names = HDFGetShotNames(filename),
  shot_names = {};
  fid = H5F.open(filename);

  top_gid = H5G.open(fid, '/');
  top_info = H5G.get_info(top_gid);

  for i = 1:top_info.nlinks
    %fprintf(' %d : ', i);
    shot_names{i} = H5L.get_name_by_idx(fid, '/', 'H5_INDEX_NAME', ...
                                        'H5_ITER_INC', i-1, 'H5P_DEFAULT');
    %fprintf('"%s"\n', shot_names{i});
  end

  H5G.close(top_gid);
  H5F.close(fid);
end
