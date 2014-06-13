% -*- mode: Matlab -*-
% Time-stamp: "2011-09-21 22:58:19 sb"

%  file       FitWriteResults.m
%  copyright  (c) Sebastian Blatt 2011

function FitWriteResults(file,fitResults)
  % Write FITRESULTS to path FILE, where FITRESULTS is a 2D cell array of
  % fit result structs. The first dimension indexes the shot, and the
  % second dimension indexes the camera used.
  fid = fopen(file,'wt');
  fprintf(fid,'# Shot\tCamera\t');
  lbl = fitResults{1,1}.labels;
  npars = fitResults{1,1}.npars;
  for i=1:npars,
    fprintf(fid,'%s\td%s',lbl{i},lbl{i});
    if i<npars,
      fprintf(fid,'\t');
    else
      fprintf(fid,'\n');
    end
  end

  sz = size(fitResults);
  ndata = sz(1);
  ncamera = sz(2);
  for i=1:ndata,
    for k=1:ncamera,
      fprintf(fid,'%04i\t%d\t',i-1,k-1);
      res = fitResults{i,1};
      for j=1:npars,
        fprintf(fid,'%g\t%g',res.parameters(j),res.errors(j));
        if j<npars,
          fprintf(fid,'\t');
        else
          fprintf(fid,'\n');
        end
      end
    end
  end
  fclose(fid);
end
